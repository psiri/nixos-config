{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };

          # python = pkgs.python3.override {
          #   self = python;
          #   packageOverrides = python-self: python-super: {
          #     redshift-connector = python-super.redshift-connector.overridePythonAttrs (oldAttrs: {
          #       # redshift-connector tests don't work
          #       doCheck = false;
          #     });
          #     google-cloud-bigquery = python-super.google-cloud-bigquery.overridePythonAttrs (oldAttrs: {
          #       # this package marked as broken, so normally we need run NIXPKGS_ALLOW_BROKEN=1; nix develop --impure
          #       # however, we can override that here, because we like to live dangerously
          #       meta = oldAttrs.meta // { broken = false; };
          #       doCheck = false;
          #       propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ python-super.packaging ];
          #     });
          #   };
          # };

          # pandas-gbq and db-types are not in nixpkgs so we will define them here
          pan-python = pkgs.python3Packages.buildPythonPackage rec {
            pname = "pan-python";
            version = "0.25.0";

            src = pkgs.fetchFromGitHub {
              owner = "kevinsteves";
              repo = "pan-python";
              rev = "0.25.0";
              #sha256 = "USs9VCJWkgOY2XXMiCA1RO3Bw+C+SGblRHNnOZ0pWjs=";
            };

            #doCheck = false; # check requires infrastructure
          };


        
          # YAML extension module for including YAML files from within YAML files
          # pyyaml-include = pkgs.python3Packages.buildPythonPackage rec {
          #   pname = "pyyaml-include";
          #   version = "1.3.1";
          #   pyproject = true;
          #   src = pkgs.python3Packages.fetchPypi {
          #     inherit pname version;
          #     hash = "sha256-TLO04bquLsJRgI/h6K7V09IGmcVBhkyOR+2GarLxUDk=";
          #   };
          #   nativeBuildInputs = [
          #     pkgs.python3Packages.setuptools-scm
          #   ];
          # };

        in
        with pkgs;
        {
          devShells.default = mkShell {
            name = "py-defaults";
            packages = [
              # put any non-Python packages here
              # google-cloud-sdk
              # Python packages:
              (python.withPackages (p: with p; [
                pan-python
              ]))
            ];

            shellHook = ''
            echo "Default Python packages"
            '';
          };
        }
      );
}