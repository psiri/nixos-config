{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./config.jsonc.nix
    ./style.css.nix
  ];

  home-manager.users.${user} = {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar.override (oldAttrs: {pulseSupport = true;});
    };
    home.file.".config/hypr/per-app/waybar.conf" = {
      text = ''
        exec-once = waybar
      '';
    };
    home.file.".config/hypr/per-app/waybar-reload.conf" = {
      text = ''
        bind = $mainMod CTRL SHIFT, R, exec, pkill waybar && hyprctl dispatch exec waybar
      '';
    };
  };
}
