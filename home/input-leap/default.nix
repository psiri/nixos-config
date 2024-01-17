{
  config,
  inputs,
  outputs,
  user,
  pkgs,
  nixpkgs-unstable,
  ...
}: 

# let
#   nixpkgs-unstable-input-leap = builtins.fetchurl "https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/applications/misc/input-leap/default.nix";
#   #builtins.fetchurl "https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/misc/input-leap";
# in

{
  users.users.${user}.packages = [ nixpkgs-unstable.input-leap ];
  #imports = [ "${nixpkgs-unstable-input-leap}" ];
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

