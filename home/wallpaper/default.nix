{}
#  pkgs,
#  nix-colors,
#  inputs,
#  ...
#}: let
#  inherit nix-colors-lib = nix-colors.lib.contrib {inherit pkgs;};
#in {
#  colorScheme = nix-colors-lib.colorSchemeFromPicture {
#    path = ./nixos/wallpaper;
#    kind = "dark";
#  };
#}

