{ lib
, stdenv
, fetchurl
, testVersion
, hello
}:

stdenv.mkDerivation rec {
  pname = "lan-mouse";
  version = "0.5.1";

  src = fetchurl {
    url = "https://github.com/feschber/lan-mouse/archive/refs/tag/v${version}.tar.gz";
    #sha256 = "";
  };

  #doCheck = true;

  meta = with lib; {
    description = "Lan Mouse is a mouse and keyboard sharing software similar to universal-control on Apple devices.";
    longDescription = ''
      Lan Mouse is a mouse and keyboard sharing software similar to universal-control on Apple devices. It allows for using multiple pcs with a single set of mouse and keyboard. This is also known as a Software KVM switch.

      The primary target is Wayland on Linux but Windows and MacOS and Linux on Xorg have partial support as well (see below for more details).
    '';
    homepage = "https://github.com/feschber/lan-mouse";
    changelog = "https://github.com/feschber/lan-mouse?tab=readme-ov-file";
    license = licenses.gpl3;
    #maintainers = [ maintainers.eelco ];
    platforms = platforms.all;
  };
}