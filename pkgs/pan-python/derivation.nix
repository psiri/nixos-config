{ pkgs
, buildPythonPackage
# , lib
# , fetchPypi
, setuptools
, setuptools.build_meta
, wheel
}:

buildPythonPackage rec {
  pname = "pan-python";
  version = "0.25.0";

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-QIIZ/zusCsao7fCpTYzsl49rCavtD6b1uBnR1TnBDnI=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  # nativeBuildInputs = [];
  build-system = [
    setuptools
    wheel
  ];

  # meta = {
  #   description = "Multi-tool set for Palo Alto Networks PAN-OS, Panorama, WildFire and AutoFocus";
  #   homepage = "https://github.com/kevinsteves/pan-python";
  #   #license = licenses.ISC;
  #   #maintainers = with maintainers; [ "kevin.steves@pobox.com" ];
  # };
}
