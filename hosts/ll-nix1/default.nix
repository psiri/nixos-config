let
  scheme = "tokyo-night-dark";
in
  {
    config,
    pkgs,
    lib,
    inputs,
    outputs,
    nix-colors,
    user,
    ...
  }: {
    imports = [
      nix-colors.homeManagerModules.default
      ./per-device.nix             # per device hypr configuration
      ./hardware-configuration.nix # device-specific hardware configuration
      ../standard.nix              # standard or server config template
      #../../home/barrier          # Does not support Wayland
      #../../home/codium
      #../../home/copyq
      #../../home/input-leap
      #../../home/rkvm
      ./disko-config.nix           # device-specific declarative disk partitioning and file system configuration
      ./impermanence.nix
    ];

    sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt"; # This is using an age key that is expected to already be in the filesystem
    sops.defaultSopsFormat = "yaml";
    sops.secrets.user_password_hashed.neededForUsers = true;
    sops.secrets."hello_world" = { }; # Example secret. Will be mounted at /run/secrets/hello_world

    ################# LOCAL SECRETS MANAGEMENT ################################
    # uncomment this line to use sops secrets within the local repo
    #sops.defaultSopsFile = ../../secrets/secrets.yaml;
    ################# PRIVATE SECRETS MANAGEMENT ##############################
    # uncomment this line to use sops secrets stores within a private repo
    # this will attempt to clone the (private) repo at the path defined 
    # in the "private-secrets" input defined within flake.nix
    sops.defaultSopsFile = "${builtins.toString inputs.private-secrets}/secrets/secrets.yaml";
    # NOTE: If there are changes to the repo, run "nix flake lock --update-input private-secrets"


    colorscheme = inputs.nix-colors.colorSchemes.${scheme};
    home-manager.users.${user}.colorscheme = inputs.nix-colors.colorSchemes.${scheme};

    networking = {
      enableIPv6 = false;
      hostName = "ll-nix1";
      hostId = "66c98433"; # FIXME required for ZFS. Should be unique.
      firewall.enable = true;
      networkmanager.enable = true;
    };

    hardware.opengl.enable = true;

    environment = {
      systemPackages = with pkgs; [
        age
        qmk
        qmk-udev-rules
        sops
        # Necessary for Gnome to use the ambient light sensor
        #iio-sensor-proxy
      ];
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch main https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#ll-nix1 --impure";
    };

    services = {
      fprintd.enable = true;
      fwupd.enable = true;
      #pcscd.enable = true;
      #power-profiles-daemon.enable = true;
      udev.packages = [ pkgs.via ];
    };

  }
