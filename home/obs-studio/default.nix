{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    plugins = [ # List of plugins to install

    ];
  };
  home.file.".config/hypr/per-app/obs-studio.conf" = {
    text = ''
      # windowrulev2 = opacity 0.8 0.8, class:^(obs-studio)$
      # windowrulev2 = size 700 300, class:^(obs-studio)$
      # windowrulev2 = tile, class:^(obs-studio)$
      bind = $mainMod, O, exec, obs
    '';
  };
}
