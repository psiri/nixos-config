{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  imports = [./style.nix];

  home-manager.users.${user}.home.file.".config/hypr/per-app/wofi.conf" = {
    text = ''
      bind = $mainMod, R, exec, wofi --show run
    '';
  };

  home-manager.users.${user}.programs.wofi = {
    enable = true;
    settings = {
      width = 500;
      height = 300;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
    };
  };
}
