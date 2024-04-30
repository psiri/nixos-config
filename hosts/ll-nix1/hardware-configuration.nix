{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "ahci" "usbhid" "usb_storage" "uas" "sd_mod" "pci_stub" "vfio" "vfio-pci" "vfio_iommu_type1" "virtio_net" "virtio_pci" "virtio_mmio" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ];
  boot.initrd.kernelModules = [ "vfio" "vfio-pci" ]; 

# The following section handles automatically "destroying" the  root filesystem every boot
# by rolling-back to the initial blank zfs snapshot created during initial configuration (by disko via "disko-config.nix" in our case)
#
# Note: if you set a temporary password for your user (or root), for example with the "initialPassword" parameter
#       then the rollback will also restore these to their initial values!
  #boot.initrd.systemd.enable = lib.mkDefault true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback root filesystem to a pristine state on boot";
    wantedBy = [
      "initrd.target"
    ];
    after = [
      "zfs-import-zroot.service" # FIXME change "zroot" to the name of your specific zpool. Defined in "disko-config.nix".
    ];
    before = [
      "sysroot.mount"
    ];
    path = with pkgs; [
      zfs
    ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      zfs rollback -r zroot/encrypted/root@blank && echo "  >> >> rollback complete << <<"
    '';
      # zfs rollback -r zroot/encrypted/home@blank
      # FIXME - IMPORTANT - change "zroot" to the name of your specific zpool. Defined in "disko-config.nix".
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never
  ''; # Prevents sudo warnings that reset after root rollback

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.requestEncryptionCredentials = true; # Prompts for password input. If you wish to have interactive-authentication, set to true.
  boot.zfs.allowHibernation = false;
  services.zfs = {
    autoScrub.enable = true;
    autoScrub.pools = [ "zroot" ]; # FIXME change "zroot" to the name of your specific zpool. Defined in "disko-config.nix".
    trim.enable = true;
  };

  boot.kernelModules = [ 
    "pci_stub"
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "kvmfr"
  ];
  boot.kernelParams = [
    #"iommu=pt" # Required if doing passthrough to VMs / Docker
    # "pcie_aspm=off"
    # "amd_iommu=on"
    #"vfio-pci.ids=1002:7480,1002:ab30"
    #"pci-stub.ids=1002:7480,1002:ab30"
    "mem_sleep_default=deep" # Fix for AMD-related power-draw while syspended/sleeping
  ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.extraModulePackages = [ ];

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    keyboard.qmk.enable = true;
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      enable = true;
    };
  };

}
