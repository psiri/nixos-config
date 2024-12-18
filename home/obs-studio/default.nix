{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    programs.obs-studio = {
      enable = true;
      plugins = [ # List of plugins to install
        pkgs.obs-studio-plugins.wlrobs
      ];
    };
    home.file.".config/hypr/per-app/obs-studio.conf" = {
      text = ''
        # windowrulev2 = tile, class:^(obs-studio)$
        windowrulev2 = opacity 1.0 1.0, class:^(com.obsproject.Studio)$   # Disables opacity of OBS windows
        windowrulev2 = nodim, class:^(com.obsproject.Studio)$             # Disables dimming of OBS windows
        bind = $mainMod, O, exec, obs
      '';
    };
  };
}
