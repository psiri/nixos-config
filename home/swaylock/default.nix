{
  config,
  pkgs,
  user,
  ...
}: {
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  home-manager.users.${user} = {
    programs.swaylock = {
      enable = true;
      settings = {
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 200;
        indicator-thickness = 20;
        indicator-caps-lock = true;
        show-failed-attempts = true;
        timestr = "%R";
        datestr = "%a %e %B";
        effect-blur="5x2";
        image="$HOME/Pictures/Wallpaper/4,jpg";
      };
    };
    home.file.".config/hypr/per-app/swaylock.conf" = {
      text = ''
        bind = $mainMod, L, exec, swaylock -c ff000000
      '';
    };
  };
}
