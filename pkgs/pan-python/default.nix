{ pkgs ? import <nixpkgs> {} }:

( let
    pan-python = pkgs.callPackage ./derivation.nix { pkgs=pkgs; buildPythonPackage=pkgs.python311Packages.buildPythonPackage; setuptools=pkgs.python311Packages.setuptools; wheel=pkgs.python311Packages.wheel; };
  in pkgs.python311.buildEnv.override rec {
    extraLibs = [ pkgs.python311Packages.setuptools pkgs.python311Packages.wheel pkgs.python311Packages.virtualenv pan-python ];
}
).env