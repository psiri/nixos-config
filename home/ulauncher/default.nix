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
      windowrulev2 = noborder, class:^(ulauncher)$
      windowrulev2 = noshadow, class:^(ulauncher)$
      windowrulev2 = noblur, class:^(ulauncher)$
      bind = $mainMod, SPACE, exec, ulauncher-toggle
    '';
  };

  home-manager.users.${user}.home.file.".config/ulauncher/settings.json" = {
    text = ''
      {
        "blacklisted-desktop-dirs": "/usr/share/locale:/usr/share/app-install:/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5:/usr/share/applications/screensavers:/usr/share/kde4:/usr/share/mimelnk",
        "clear-previous-query": true,
        "disable-desktop-filters": true,
        "grab-mouse-pointer": true,
        "hotkey-show-app": "<Super>b",
        "render-on-screen": "mouse-pointer-monitor",
        "show-indicator-icon": false,
        "show-recent-apps": "0",
        "terminal-command": "",
        "theme-name": "TokyoNight-Theme"
      }
    '';
  };

  imports = [
    ./manifest.json.nix
    ./theme-gtk-3.20.css.nix
    ./theme.css.nix
  ];
}
