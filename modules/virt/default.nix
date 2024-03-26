{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        swtpm.enable = true;
        swtpm.package = pkgs.swtpm;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.${user}.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    libguestfs
    qemu_kvm
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    virtio-win
    win-spice
    gnome.adwaita-icon-theme
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