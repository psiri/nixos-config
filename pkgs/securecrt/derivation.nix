{ stdenv, dpkg, glibc, gcc-unwrapped, autoPatchelfHook, libxcb, libX11, libxkbcommon, cups, libpng, openssl, python310, krb5, xcb-util-cursor, brotli, icu70, freetype, xcbutilkeysyms, fontconfig, argyllcms, xcbutilwm, pkgs }:

let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "9.5.0-3241";
  allowUnfree = true;
  nixpkgs.config.allowUnfree = true;
  autoPatchelfIgnoreMissingDeps = true;
  QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";
  src = ./scrt-sfx-9.5.0-3241.ubuntu22-64.x86_64.deb;

in stdenv.mkDerivation {
  name = "scrt-sfx-${version}";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
    libxcb
    libX11
    libxkbcommon
    cups
    libpng
    openssl
    python310
    krb5
    xcb-util-cursor
    brotli
    icu70
    freetype
    xcbutilkeysyms
    fontconfig
    argyllcms
    xcbutilwm
  ] ++ [ pkgs.qt5.qtbase pkgs.qt5.wrapQtAppsHook];

  # Required at running time
  buildInputs = [
    glibc
    gcc-unwrapped
  ] ++ [ pkgs.qt5.qtbase pkgs.qt5.wrapQtAppsHook]; #++ [ pkgs.xorg.libxcb pkgs.xorg.libX11 pkgs.libxkbcommon];

  #dontWrapQtApps = true;
  #wrapQtAppsHook = 1;

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    # cp -av $out/opt/vandyke/securecrt/* $out
    # rm -rf $out/opt
  '';

  meta = with stdenv.lib; {
    description = "secureCRT";
    homepage = https://www.vandyke.com/products/securecrt/;
    #license = licenses.unfree;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}