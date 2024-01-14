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

  users.users.${user}.packages = with pkgs; [swaylock-effects];

  home-manager.users.${user} = {
    programs.swaylock = {
      enable = true;
      settings = {
        clock = true;
        fade-in = 1; # Fade in time
        font = "Hack Nerd Font Mono";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 200;
        indicator-thickness = 20;
        indicator-caps-lock = true;
        show-failed-attempts = true;
        timestr = "%R";
        datestr = "%a %e %B";
        effect-blur="5x2";
        image="~/Pictures/Wallpaper/4.jpg";
      };
    };
    home.file.".config/hypr/per-app/swaylock.conf" = {
      text = ''
        bind = $mainMod, L, exec, swaylock -c ff000000
      '';
    };
  };
}
