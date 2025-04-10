
{
  rustPlatform,
  gpauth,
  openconnect,
  openssl,
  perl,
  vpnc-scripts,
  jq,
  webkitgtk_4_1,
  libsoup_3,
  pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "gpclient";

  inherit (gpauth) version src meta;

  buildAndTestSubdir = "apps/gpclient";
  cargoHash = "sha256-8LSGuRnWRWeaY6t25GdZ2y4hGIJ+mP3UBXRjcvPuD6U=";

  nativeBuildInputs = [ perl jq webkitgtk_4_1 libsoup_3 pkg-config ];
  PKG_CONFIG_PATH = "${openssl.dev}/lib/pkgconfig";
  buildInputs = [
    gpauth
    openconnect
    openssl
    webkitgtk_4_1
  ];

  preConfigure = ''
    substituteInPlace crates/gpapi/src/lib.rs \
      --replace-fail /usr/bin/gpauth ${gpauth}/bin/gpauth
    substituteInPlace crates/common/src/vpn_utils.rs \
      --replace-fail /usr/sbin/vpnc-script ${vpnc-scripts}/bin/vpnc-script
  '';

  postInstall = ''
    mkdir -p $out/share/applications
    cp packaging/files/usr/share/applications/gpgui.desktop $out/share/applications/gpgui.desktop
  '';

  postFixup = ''
    substituteInPlace $out/share/applications/gpgui.desktop \
      --replace-fail /usr/bin/gpclient $out/bin/gpclient
  '';
}