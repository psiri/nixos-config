{pkgs, ...}: let
  pan-python = pythonPkgs:
    pythonPkgs.buildPythonPackage rec {
      pname = "pan-python";
      version = "0.25.0";

      src = pythonPkgs.fetchPypi {
        pname = "pan-python";
        version = "0.25.0";
        #sha256 = "sha256-U6T/aXy0JTC1ptL5oBmch0ytSPmIkRA8XOi31NpArnI=";
      };

      nativeBuildInputs = with pkgs; [];
      pyproject = true;

      propagatedBuildInputs = with pythonPkgs; [
      ];

      dontUseCmakeConfigure = true;

      meta = with pkgs.lib; {
        description = "Multi-tool set for Palo Alto Networks PAN-OS, Panorama, WildFire and AutoFocus ";
        homepage = "https://github.com/kevinsteves/pan-python";
        license = licenses.isc;
      };
    };

  pan-python = pkgs.pan-python.withPackages (p: [(py-slvs p)]);
in
  pan-python























# {
#   config,
#   inputs,
#   outputs,
#   pkgs,
#   user,
#   ...
# }: 

#   let
#     # python = pkgs.python3.override {
#     #   self = python;
#     #   packageOverrides = python-self: python-super: {
#     #     redshift-connector = python-super.redshift-connector.overridePythonAttrs (oldAttrs: {
#     #       # redshift-connector tests don't work
#     #       doCheck = false;
#     #     });
#     #     google-cloud-bigquery = python-super.google-cloud-bigquery.overridePythonAttrs (oldAttrs: {
#     #       # this package marked as broken, so normally we need run NIXPKGS_ALLOW_BROKEN=1; nix develop --impure
#     #       # however, we can override that here, because we like to live dangerously
#     #       meta = oldAttrs.meta // { broken = false; };
#     #       doCheck = false;
#     #       propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ python-super.packaging ];
#     #     });
#     #   };
#     # };

#     pan-python = pkgs.python3Packages.buildPythonPackage rec {
#       pname = "pan-python";
#       version = "0.25.0";

#       src = pkgs.fetchFromGitHub {
#         owner = "kevinsteves";
#         repo = "pan-python";
#         rev = "0.25.0";
#         #sha256 = "OAVHx/a4uupVGXSWN2/3uem9/4i+TUkzTX4kp0uLY44=";
#       };
#     };

#   in

#   {
#   users.users.${user}.packages = with pkgs; [
#     python3.withPackages [
#       pan-python
#     ]
#   ];
# }

  # {
  #   devShells.default = mkShell {
  #     name = "default python";
  #     packages = [
  #       # put any non-Python packages here
  #       # google-cloud-sdk
  #       # Python packages:
  #       (python.withPackages (p: with p; [
  #         pan-python
  #       ]))
  #     ];

  #     shellHook = ''
  #     echo "Installed Pyhton Packages"
  #     '';
  #   };
  # }
#}  