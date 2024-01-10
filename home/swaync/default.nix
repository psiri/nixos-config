{
  pkgs,
  config,
  lib,
  user,
  ...
}: {
  users.users.${user}.packages = with pkgs; [
    swaynotificationcenter
  ];
  imports = [
    ./config.nix
    ./style.nix
    ./configSchema.nix
  ];
}
