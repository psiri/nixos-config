{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  programs.thunar = {
    enable = true;
    plugins = [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
