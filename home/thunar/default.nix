{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  lib,
  ...
}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services = {
    gvfs = {
      enable = true; # Mount, trash, and other functionalities
      package = lib.mkForce pkgs.gnome3.gvfs; # use the gnome versions to support smb:// in thunar
    };
    tumbler = {
      enable = true; # Thumbnail support for images
    };
  };
}
