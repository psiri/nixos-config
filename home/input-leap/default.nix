{
  config,
  inputs,
  outputs,
  user,
  pkgs,
  ...
}: 

let
  nixpkgs-unstable-input-leap = "github:nixos/nixpkgs/nixos-unstable/pkgs/misc/input-leap";
  #builtins.fetchurl "https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/misc/input-leap";
in

{
  imports = [ "${nixpkgs-unstable-input-leap}" ];
}


#   let
#     fetch-unstable = pkg: pkg.override (origArgs: builtins.intersectAttrs origArgs self);
#     nixpkgs-unstable = import <nixpkgs-unstable> {};
#   in

# {
#   input-leap-unstable = assert (! super ? input-leap-unstable); (cherryPick nixpkgs-unstable.input-leap).override {
#     llvmPackages = self.llvmPackages_11;
#   };
# }

