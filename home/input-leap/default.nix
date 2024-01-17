{
  config,
  inputs,
  outputs,
  user,
  pkgs,
  ...
}: 

let
  nixos-unstable = import <nixos-unstable> {
    # Include the nixos config when importing nixos-unstable
    # But remove packageOverrides to avoid infinite recursion
    config = removeAttrs config.nixpkgs.config [ "packageOverrides" ];
  };
in
{
  disabledModules = [ "programs/input-leap.nix" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Override the input-leap module
      <nixos-unstable/nixos/modules/programs/input-leap.nix>
    ];

  # Override select packages to use the unstable channel
  nixpkgs.config.packageOverrides = pkgs: {
    input-leap = nixos-unstable.input-leap;
  };

  users.users.${user}.packages = [ pkgs.input-leap ];
}



################### OPT 1

# let
#   nixpkgs-unstable-input-leap = builtins.fetchurl "https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/applications/misc/input-leap/default.nix";
#   #builtins.fetchurl "https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/misc/input-leap";
# in









################# OPT 2

#   let
#     fetch-unstable = pkg: pkg.override (origArgs: builtins.intersectAttrs origArgs self);
#     nixpkgs-unstable = import <nixpkgs-unstable> {};
#   in

# {
#   input-leap-unstable = assert (! super ? input-leap-unstable); (cherryPick nixpkgs-unstable.input-leap).override {
#     llvmPackages = self.llvmPackages_11;
#   };
# }

