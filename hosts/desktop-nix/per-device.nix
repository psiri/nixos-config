{user, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=,3840x2160,auto,auto
    '';
  };
}
