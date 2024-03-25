{
  config,
  pkgs,
  inputs,
  user,
  ...
}: {
  programs.hyprland = {
    enable = true;
  };

  users.users.${user}.packages = with pkgs; [hyprpaper];

  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
  ];
}
