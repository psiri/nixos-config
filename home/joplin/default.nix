{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  sops.templates."joplin-settings-with-secrets.json".path = "/home/${user}/.config/joplin-desktop/settings.json";
  sops.templates."joplin-settings-with-secrets.json".owner = "${user}";
  sops.templates."joplin-settings-with-secrets.json".mode = "0600";
  sops.templates."joplin-settings-with-secrets.json".content = ''
  {
    "$schema": "https://joplinapp.org/schema/settings.json",
    "sync.interval": 600,
    "sync.target": 8,
    "locale": "en_US",
    "markdown.plugin.softbreaks": true,
    "markdown.plugin.typographer": false,
    "spellChecker.languages": [
      "en-US"
    ],
    "noteVisiblePanes": [
      "editor",
      "viewer"
    ],
    "ui.layout": {
      "key": "root",
      "children": [
        {
          "key": "sideBar",
          "width": 250,
          "visible": true
        },
        {
          "key": "noteList",
          "width": 250,
          "visible": true
        },
        {
          "key": "editor",
          "visible": true
        }
      ],
      "visible": true
    },
    "sync.8.path": "${config.sops.placeholder.joplin_sync_path}",
    "sync.8.url": "${config.sops.placeholder.joplin_sync_url}",
    "sync.8.region": "${config.sops.placeholder.joplin_sync_region}",
    "sync.8.username": "${config.sops.placeholder.joplin_sync_username}",
    "api.token": "${config.sops.placeholder.joplin_sync_api_token}",
    "sync.maxConcurrentConnections": 30,
    "timeFormat": "h:mm A",
    "dateFormat": "MM/DD/YYYY",
    "theme": 22,
    "showTrayIcon": true,
    "editor.codeView": false
  }
  '';

  home-manager.users.${user} = {
    programs.joplin-desktop = {
      enable = true;
    #   sync.interval = "10m";
    #   sync.target = "s3";
    #   extraConfig = {
    #     "locale" = "en_US";
    #     "markdown.plugin.softbreaks" = false;
    #     "markdown.plugin.typographer" = false;
    #     "spellChecker.languages" = ["en-US"];
    #     "noteVisiblePanes" = [
    #       "editor"
    #       "viewer"
    #     ];
    #     "sync.8.path" = config.sops.secrets.joplin_sync_path.path;
    #     "sync.8.url" = config.sops.secrets.joplin_sync_url.path;
    #     "sync.8.region" = config.sops.secrets.joplin_sync_region.path;
    #     "sync.8.username" = cat ${config.sops.secrets.joplin_sync_username.path};
    #     "sync.maxConcurrentConnections" = 30;
    #     "timeFormat" = "h:mm A";
    #     "dateFormat" = "MM/DD/YYYY";
    #     "theme" = 22;
    #     "showTrayIcon" = true;
    #     "editor.codeView" = false;
    #   };
    };
  };

}
