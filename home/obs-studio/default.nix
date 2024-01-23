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
  # home.file.".config/obs-stuio.conf" = {
  #   text = ''
  #     windowrulev2 = opacity 0.8 0.8, class:^(kitty)$
  #   '';
  # };
  };
}
