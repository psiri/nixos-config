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
        indicator-rafius = 100;
        show-failed-attempts = true;
      };
    };
    home.file.".config/hypr/per-app/swaylock.conf" = {
      text = ''
        bind = $mainMod, L, exec, swaylock -c ff000000
      '';
    };
  };
}
