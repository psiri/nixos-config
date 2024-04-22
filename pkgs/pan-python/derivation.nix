{ pkgs
, lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "pan-python";
  version = "0.25.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-CP3V73yWSArRHBLUct4hrNMjWZlvaaUlkpm1QP66RWA=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  nativeBuildInputs = [
    setuptools
    wheel
  ];
  build-system = [
    setuptools
    wheel
  ];

  meta = with lib; {
    description = "Multi-tool set for Palo Alto Networks PAN-OS, Panorama, WildFire and AutoFocus";
    homepage = "https://github.com/kevinsteves/pan-python";
    license = licenses.ISC;
    maintainers = with maintainers; [ "kevin.steves@pobox.com" ];
  };
}
