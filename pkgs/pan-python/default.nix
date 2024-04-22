{ pkgs ? import <nixpkgs> {} }:

( let
    pan-python = pkgs.callPackage ./derivation.nix { pkgs=pkgs; buildPythonPackage=pkgs.python311Packages.buildPythonPackage; setuptools=python311Packages.setuptools; };
  in pkgs.python311.buildEnv.override rec {
    extraLibs = [ pan-python ];
}
).env