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

  users.users.${user}.packages = with pkgs; [
    hyprpaper
    hypridle
    hyprlock
  ];

  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];
}
