{ pkgs ? import <nixpkgs> {} }:

(pkgs.callPackage ./gpclient.nix { gpauth = (pkgs.callPackage ./gpauth.nix {}); })
