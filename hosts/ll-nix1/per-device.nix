{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      # Desktop middle monitor
      monitor=DP-1,3840x2160@60,auto,1.5
      # Desktop left monitor
      monitor=DP-2,3840x2160@60,auto,1.5,transform,1
      # monitor=DP-2,disable
      # Built-in display
      monitor=eDP-1,preferred,auto,1
      #monitor=eDP-1,disable
    '';
  };
}
