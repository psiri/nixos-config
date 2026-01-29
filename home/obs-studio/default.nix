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
        # windowrule = tile on, match:class ^(obs-studio)$
        windowrule = opacity 1.0 1.0, match:class ^(com.obsproject.Studio)$   # Disables opacity of OBS windows
        windowrule = no_dim on, match:class ^(com.obsproject.Studio)$         # Disables dimming of OBS windows
        bind = $mainMod, O, exec, obs
      '';
    };
  };
}
