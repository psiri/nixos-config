{inputs, ... }: {
  # When applied, the unstable nixpkgs set (declared in flake.nix inputs) will
  # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };


  # pipewire overlay for broken zoom-us
  # pipewireOverlay = f: p: {
  #   pipewire-zoom = inputs.nixpkgs.legacyPackages.x86_64-linux.pipewire;
  # };


  # pkgs.zoom-us.overrideAttrs (attrs: {
  #   nativeBuildInputs = (attrs.nativeBuildInputs or []) ++ [ pkgs.bbe ];
  #   postFixup = ''
  #     cp $out/opt/zoom/zoom .
  #     bbe -e 's/\0manjaro\0/\0nixos\0\0\0/' < zoom > $out/opt/zoom/zoom
  #   '' + (attrs.postFixup or "") + ''
  #     sed -i 's|Exec=|Exec=env XDG_CURRENT_DESKTOP="gnome" |' $out/share/applications/Zoom.desktop
  #   '';
  # })
}