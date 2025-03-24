{
  rustPlatform,
  lib,
  fetchFromGitHub,
  pkg-config,
  perl,
  jq,
  webkitgtk_4_1,
  libsoup_3,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "gpauth";
  version = "2.4.4";

  src = fetchFromGitHub {
    owner = "yuezk";
    repo = "GlobalProtect-openconnect";
    rev = "v${version}";
    hash = "sha256-MY4JvftrC6sR8M0dFvnGZOkvHIhPRcyct9AG/8527gw=";
  };

  buildAndTestSubdir = "apps/gpauth";
  cargoHash = "sha256-JR7COu/xbpO43cJ25MvQ0qT1hovY+VT8LeqZiizJims=";

  nativeBuildInputs = [
    perl
    pkg-config
  ];
  buildInputs = [
    libsoup_3
    webkitgtk_4_1
    openssl
    pkg-config
  ];
  PKG_CONFIG_PATH = "${openssl.dev}/lib/pkgconfig";

  meta = with lib; {
    changelog = "https://github.com/${src.owner}/${src.repo}/blob/${src.rev}/changelog.md";
    description = "A CLI for GlobalProtect VPN, based on OpenConnect, supports the SSO authentication method";
    longDescription = ''
      A CLI for GlobalProtect VPN, based on OpenConnect, supports the SSO
      authentication method. Inspired by gp-saml-gui.
      The CLI version is always free and open source in this repo. It has almost
      the same features as the GUI version.
    '';
    homepage = "https://github.com/${src.owner}/${src.repo}";
    license = with licenses; [ gpl3Only ];
    maintainers = with maintainers; [ binary-eater ];
  };
}