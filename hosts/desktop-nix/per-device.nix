{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=,3840x2160,auto,1.5
      monitor=DP-2,3840x2160,0x0,1.5
      monitor=DP-3,3840x2160,-2560x0,1.5,transform,1
    '';
  };
}
