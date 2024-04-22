{ pkgs ? import <nixpkgs> {} }:

( let
    pan-python = pkgs.callPackage ./derivation.nix { pkgs=pkgs; buildPythonPackage=pkgs.python311Packages.buildPythonPackage; setuptools=pkgs.python311Packages.setuptools; wheel=pkgs.python311Packages.wheel; };
  in pkgs.python311.buildEnv.override rec {
    extraLibs = [ pan-python ];
  }
).env