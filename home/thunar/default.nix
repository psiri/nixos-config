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
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
