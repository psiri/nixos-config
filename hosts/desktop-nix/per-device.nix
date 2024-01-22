{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=DP-2,3840x2160@144,auto,1.5
      monitor=DP-3,3840x2160@60,auto,1.5,transform,1
    '';
  };
}
