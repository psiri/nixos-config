{ stdenv, dpkg, glibc, gcc-unwrapped, autoPatchelfHook }:
let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "9.5.0-3241";

  src = ~/Downloads/scrt-sfx-9.5.0-3241.ubuntu22-64.x86_64.deb;

in stdenv.mkDerivation {
  name = "securecrt-${version}";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
  ];

  # Required at running time
  buildInputs = [
    glibc
    gcc-unwrapped
  ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/opt/securecrt/securecrt/* $out
    rm -rf $out/opt
  '';

  meta = with stdenv.lib; {
    description = "secureCRT";
    homepage = https://www.vandyke.com/products/securecrt/;
    license = licenses.unfree;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}