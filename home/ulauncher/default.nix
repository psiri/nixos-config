{
  pkgs,
  user,
  ...
}: {
  # TODO nix-colors done?
  users.users.${user}.packages = with pkgs; [ulauncher];

  home-manager.users.${user}.home.file.".config/hypr/per-app/ulauncher.conf" = {
    text = ''
      exec-once = sleep 1 && ulauncher --hide-window
      windowrule = border_size 0, match:class ^(ulauncher)$
      windowrule = no_shadow on, match:class ^(ulauncher)$
      windowrule = no_blur on, match:class ^(ulauncher)$
      bind = $mainMod, SPACE, exec, ulauncher-toggle
    '';
  };

  imports = [
    ./manifest.json.nix
    ./theme-gtk-3.20.css.nix
    ./theme.css.nix
    ./settings.json.nix
  ];
}
