{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=,1920x1080@60,auto,1
    '';
  };
}
