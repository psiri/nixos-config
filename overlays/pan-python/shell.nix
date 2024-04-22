let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: [
      # select Python packages here
      python-pkgs.requests
      (pkgs.callPackage ./default.nix)
    ]))
  ];
}