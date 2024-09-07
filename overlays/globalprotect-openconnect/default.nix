self: super:

let
  # globalprotect-openconnect has added support for SAML auth and browser integration in newer
  # https://github.com/yuezk/GlobalProtect-openconnect
  version = "2.3.7";
in
{
  # globalprotect-openconnect = globalprotect-openconnect v2.3.7
  zoom-us = (super.globalprotect-openconnect { globalprotect = super.globalprotect-openconnect; }).overrideAttrs (old: {
    inherit version;

    src = super.fetchurl {
      url = "https://github.com/yuezk/GlobalProtect-openconnect/releases/download/v${version}/globalprotect-openconnect-${version}.tar.gz";
      hash = "sha256-027oAblhH8EJWRXKIEs9upNvjsSFkA0wxK1t8m8nwj8=";
    };
  });
}