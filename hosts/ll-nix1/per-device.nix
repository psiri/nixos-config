{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      # Built-in display
      monitor=eDP-1,preferred,auto,1
      # Desktop left monitor
      monitor=DP-1,3840x2160,auto,1,transform,1
      # Desktop middle monitor
      monitor=DP-2,3840x2160,auto,1
    '';
  };
}
