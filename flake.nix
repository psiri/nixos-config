{
  description = "psiri's custom nixos config flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.
    nix-colors.url = "github:misterio77/nix-colors";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    #hyprland,
    nix-colors,
    disko,
    sops-nix,
    hardware,
    ...
  } @ inputs: let
    user = "psiri"; # FIXME set your username
    plymouth_theme = "deus_ex"; # device specific?

    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    #overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    #nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    #homeManagerModules = import ./home;

    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      ll-nix1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
        modules = [
          ./hosts/ll-nix1                           # > Our host-specific nixos configuration file <
          ./modules/audio/default.nix               # Standard audio module using pipewire
          ./modules/security-hardening/default.nix  # Security hardening module

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit nix-colors inputs;};
              users.${user}.imports = [];
            };
          }
        ];
      };
      fw16-nix = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
        modules = [
          ./hosts/fw16-nix                           # > Our host-specific nixos configuration file <
          ./modules/audio/default.nix               # Standard audio module using pipewire
          ./modules/security-hardening/default.nix  # Security hardening module
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          hardware.nixosModules.framework-13-7040-amd

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit nix-colors inputs;};
              users.${user}.imports = [];
            };
          }
        ];
      };
      desktop-nix = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
        modules = [
          ./hosts/desktop-nix                        # > Our host-specific nixos configuration file <
          ./modules/audio/default.nix               # Standard audio module using pipewire
          ./modules/security-hardening/default.nix  # Security hardening module

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit nix-colors inputs;};
              users.${user}.imports = [];
            };
          }
        ];
      };
      unraid-nix = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
        modules = [
          ./hosts/unraid-nix                        # > Our host-specific nixos configuration file <
          ./modules/audio/default.nix               # Standard audio module using pipewire
          ./modules/security-hardening/default.nix  # Security hardening module

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit nix-colors inputs;};
              users.${user}.imports = [];
            };
          }
        ];
      };
      server-nix = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
        modules = [
          ./hosts/server-nix                        # > Our host-specific nixos configuration file <
          ./modules/audio/disable.nix               # disable audio
          ./modules/security-hardening/default.nix  # Security hardening module

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit nix-colors inputs;};
              users.${user}.imports = [];
            };
          }
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    # homeConfigurations = {
    #   # FIXME replace with your username@hostname
    #   "${user}@unraid-nix" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    #     extraSpecialArgs = {inherit inputs outputs user nix-colors plymouth_theme;};
    #     modules = [
    #       # > Our main home-manager configuration file <
    #       ./home/default.nix
    #     ];
    #   };
    # };
  };
}