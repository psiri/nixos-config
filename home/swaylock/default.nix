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

  # users.users.${user}.packages = with pkgs; [swaylock-effects]; # Not working when I tried this

  home-manager.users.${user} = {
    programs.swaylock = {
      enable = true;
      settings = {
        # THESE OPTIONS FAIL
        #clock = true;
        #fade-in = 1; # Fade in time
        #timestr = "%R";
        #datestr = "%a %e %B";
        #effect-blur="5x2";

        color = "ff000000";
        font = "Hack Nerd Font Mono";
        font-size = 24;
        ignore-empty-password=true;
        indicator-idle-visible = false;
        indicator-radius = 200;
        indicator-thickness = 20;
        indicator-caps-lock = true;
        show-failed-attempts = true;
        image="~/Pictures/Wallpaper/4.jpg";
        key-hl-color="00000066";
        separator-color="00000000";

        inside-color="00000033";
        inside-clear-color="ffffff00";
        inside-caps-lock-color="ffffff00";
        inside-ver-color="ffffff00";
        inside-wrong-color="ffffff00";

        ring-color="ffffff";
        ring-clear-color="ffffff";
        ring-caps-lock-color="ffffff";
        ring-ver-color="ffffff";
        ring-wrong-color="ffffff";

        line-color="00000000";
        line-clear-color="ffffffFF";
        line-caps-lock-color="ffffffFF";
        line-ver-color="ffffffFF";
        line-wrong-color="ffffffFF";

        text-color="29DBF6";
        text-clear-color="ffffff";
        text-ver-color="ffffff";
        text-wrong-color="ffffff";

        bs-hl-color="ffffff";
        caps-lock-key-hl-color="ffffffFF";
        caps-lock-bs-hl-color="ffffffFF";
        text-caps-lock-color="ffffff";

      };
    };
    home.file.".config/hypr/per-app/swaylock.conf" = {
      text = ''
        bind = $mainMod, L, exec, swaylock --image $lockimg
      '';
      #--clock --timestr "%R" --datestr "%a %e %B" --effect-blur "5x2" --indicator-radius 200 --indicator-thickness 7 --image "~/Pictures/Wallpaper/4.jpg"
    };
    # home.file.".config/swayidle/config" = {
    #   text = ''
    #     timeout 15 'swaylock --image $lockimg -f && hyprctl dispatch dpms off'
    #     resume 'hyprctl dispatch dpms on'
    #     before-sleep 'swaylock --image $lockimg -f'
    #   '';
    # };
  };
}
