{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  home-manager.users.${user} = {
    programs.joplin-desktop = {
      enable = true;
      sync.interval = "10m";
      sync.target = "s3";
      extraConfig = {
        "locale" = "en_US";
        "markdown.plugin.softbreaks" = false;
        "markdown.plugin.typographer" = false;
        "spellChecker.languages" = ["en-US"];
        "noteVisiblePanes" = [
          "editor"
          "viewer"
        ];
        "sync.8.path" = config.sops.secrets.joplin_sync_path;
        "sync.8.url" = config.sops.secrets.joplin_sync_url;
        "sync.8.region" = config.sops.secrets.joplin_sync_region;
        "sync.8.username" = config.sops.secrets.joplin_sync_username;
        "sync.maxConcurrentConnections" = 30;
        "timeFormat" = "h:mm A";
        "dateFormat" = "MM/DD/YYYY";
        "theme" = 22;
        "showTrayIcon" = true;
        "editor.codeView" = false;
      };
    };
  };
}
