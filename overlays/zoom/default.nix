#self: super:

#let
  # Zoom breaks with Pipeware 1.2+
  # https://github.com/NixOS/nixpkgs/issues/322970
  # version = "6.0.2.4680";
#in
#{
  # pipewire-zoom = pipewire v1.0.7
  # zoom-us = (super.zoom-us.override { pipewire = super.pipewire-zoom; }).overrideAttrs (old: {
  #   inherit version;

  #   src = super.fetchurl {
  #     url = "https://zoom.us/client/${version}/zoom_x86_64.pkg.tar.xz";
  #     hash = "sha256-027oAblhH8EJWRXKIEs9upNvjsSFkA0wxK1t8m8nwj8=";
  #   };
  # });

self: super: with self; {
  zoom-us = (super.zoom-us.overrideAttrs (attrs: {
    nativeBuildInputs = (attrs.nativeBuildInputs or []) ++ [ bbe ];
    postFixup = ''
      cp $out/opt/zoom/zoom .
      bbe -e 's/\0manjaro\0/\0nixos\0\0\0/' < zoom > $out/opt/zoom/zoom
    '' + (attrs.postFixup or "") + ''
      sed -i 's|Exec=|Exec=env XDG_CURRENT_DESKTOP="gnome" |' $out/share/applications/Zoom.desktop
    '';
  }));
}