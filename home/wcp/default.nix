# TODO current codebase uses BBGGRRAA colours, waiting on a fix so this can work with my current configuration
# see https://github.com/milgra/wcp/issues/6
{
  pkgs,
  config,
  lib,
  user,
  ...
}: {
  users.users.${user}.packages = with pkgs; [(callPackage ../../packages/wcp {})];

  imports = [
    ./html.nix
    ./css.nix
  ];
}
