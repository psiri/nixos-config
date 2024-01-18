{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      # Desktop left monitor
      monitor=DP-1,3840x2160@60,auto,1.5,transform,1
      # Desktop middle monitor
      monitor=DP-2,3840x2160@144,auto,1.5
      # Built-in display
      # monitor=eDP-1,preferred,auto,1
      monitor=eDP-1,disable
    '';
  };
}
