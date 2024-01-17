{
  config,
  inputs,
  outputs,
  user,
  pkgs,
  ...
}: 

let
  nixpkgs-unstable-input-leap = builtins.fetchurl "https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/input-leap";
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

