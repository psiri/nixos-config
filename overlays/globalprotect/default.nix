self: super:

let
  # globalprotect-openconnect has added support for SAML auth and browser integration in newer
  # https://github.com/yuezk/GlobalProtect-openconnect
  version = "2.3.7";
in
{
  # globalprotect-openconnect = globalprotect-openconnect v2.3.7
  globalprotect-openconnect = super.globalprotect-openconnect.overrideAttrs (old: {
    inherit version;

    #buildInputs = [ openconnect qtwebsockets qtwebengine qtkeychain webkit2gtk libsecret libayatana-appindicator libappindicator-gtk3 ];

    src = super.fetchurl {
      url = "https://github.com/yuezk/GlobalProtect-openconnect/releases/download/v${version}/globalprotect-openconnect-${version}.tar.gz";
      hash = "sha256-ip+BpBy6RxMgbu/OlMEEB2l42cTyxobR5FbCEz8uOz4=";
    };

    patchPhase = '' '';

    # patchPhase = ''
    #   substituteInPlace /globalprotect-openconnect-${version}/CMakeLists.txt \
    #     --replace-quiet /etc/gpservice $out/etc/gpservice;
    # '';
  });
}