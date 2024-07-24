{inputs, system ...}:
  # When applied, the unstable nixpkgs set (declared in flake.nix inputs) will
  # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };

  with inputs;

  let 

    # pipewire overlay for broken zoom-us
    pipewireOverlay = f: p: {
      pipewire-zoom = inputs.nixpkgs-zoom.legacyPackages.${system}.pipewire;
    };

  in
  [
    pipewireOverlay
    (import ./zoom)
  ]