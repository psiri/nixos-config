{user, pkgs, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      # Laptop screen. Explicitly set to 60Hz for battery life and as a workaround for issue with multiple external monitors
      monitor=eDP-1,2560x1600@60.00,0x0,1

      # Primary external monior (centered)
      monitor=DP-3,3840x2160@30.00,6400x0,1
      # Primary monitor when run through TB3 dock (port 1)
      monitor=DP-8,3840x2160@60.00,6400x0,1
      # Primary monitor when run through TB3 dock (port 4)
      monitor=DP-6,3840x2160@60.00,6400x0,1

      # Secondary monitor (LEFT) when run through TB3 dock (port 1)
      monitor=DP-7,3840x2160@60.00,2560x0,1
      # Secondary monitor (LEFT) when run through TB3 dock (port 4)
      monitor=DP-5,3840x2160@60.00,2560x0,1

      # Secondary external monitor. Place it to the right of primary & rotate 90 deg
      #monitor=DP-2,3840x2160@30.00, 2560x0, 1, transform, 1
      # Secondary external monitor. Place it to the right of primary (without rotation)
      monitor=DP-2,3840x2160@30.00,10240x0, 1
      #monitor=DP-2,1920x1080@60.00,10240x0, 1

      # Tertiary external monitor. Place it using auto-layout
      monitor=DP-4,3840x2160@30.00, auto, 1


      # Any other random monitor default settings
      monitor = , 3840x2160@30.00, auto, 1

      # trigger when the Lid Switch is turning on (lid closed)
      bindl = , switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
      # trigger when the Lid Switch is turning off (lid opened)
      bindl = , switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 2560x1600@60.00, 0x0, 1"
    '';
  };
}
