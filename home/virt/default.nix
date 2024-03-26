{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  programs.dconf.enable = true;

  users.users.${user} = {
    extraGroups = ["libvirtd"];
    packages = with pkgs; [
      virt-manager # TODO might need some nix added to configure using qemu as default for OOBE
      qemu # this needed with virtmanager? TODO i believe so
      libvirt
      virt-manager
      virt-viewer
      spice 
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
    ];
  };


  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
