{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    docker.extraOptions = ''--insecure-registry "http://registry.bitbodyguard.local:5000"'';
    libvirtd = {
      enable = true;
      onBoot = "start";
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        swtpm.package = pkgs.swtpm;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.${user}.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    libguestfs
    # qemu_kvm # Redundant, captured in virtualisation
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    virtio-win
    win-spice
    adwaita-icon-theme
  ];
  programs.virt-manager.enable = true;

  home-manager.users.${user} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };


  systemd.services."libvertd".reloadIfChanged = true;
}