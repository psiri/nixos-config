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
      package = lib.mkForce pkgs.gnome.gvfs; # use the gnome versions to support smb:// in thunar
    };
    tumbler = {
      enable = true; # Thumbnail support for images
    };
  };

  #networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
  # fileSystems."/mnt/nas" = {
  #   device = "//sv1-nas1.bitbodyguard.local:/";
  #   fsType = "cifs";
  #   # options = let
  #   #   # this line prevents hanging on network split
  #   #   automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

  #   # in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  # };
}
