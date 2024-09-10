{ pkgs ? import <nixpkgs> {} }:

#pkgs.callPackage ./derivation.nix {}
(pkgs.callPackage ./gpclient.nix { gpauth = (pkgs.callPackage ./gpauth.nix {}); })
