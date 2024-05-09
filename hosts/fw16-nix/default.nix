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
      ./network-manager.nix        # device-specific configurations for networkmanager with rendered secrets
      #../../home/barrier          # Does not support Wayland
      #../../home/codium
      #../../home/copyq
      #../../home/input-leap
      #../../home/rkvm
      ./disko-config.nix           # device-specific declarative disk partitioning and file system configuration
    ];



    sops.age.keyFile = "/home/psiri/.config/sops/age/keys.txt"; # This is using an age key that is expected to already be in the filesystem
    sops.defaultSopsFormat = "yaml";
    sops.secrets.user_password_hashed.neededForUsers = true;
    sops.secrets."hello_world" = { }; # Example secret. Will be mounted at /run/secrets/hello_world
    sops.secrets."joplin_sync_path" = { };
    sops.secrets."joplin_sync_url" = { };
    sops.secrets."joplin_sync_region" = { };
    sops.secrets."joplin_sync_username" = { };
    sops.secrets."joplin_sync_api_token" = { };
    # Wired Network Connection 1:
    sops.secrets."wired_connection_1_ip" = { };
    sops.secrets."wired_connection_1_dns" = { };
    sops.secrets."wired_connection_1_search_domains" = { };
    # Wireless Network Connection 1:
    sops.secrets."wireless_connection_1_ssid" = { };
    sops.secrets."wireless_connection_1_anonymous_identity" = { };
    sops.secrets."wireless_connection_1_identity" = { };
    sops.secrets."wireless_connection_1_password" = { };
    # Wireguard Network Connection 1:
    sops.secrets."wireguard_connection_1_private_key" = { };
    sops.secrets."wireguard_connection_1_peer_public_key" = { };
    sops.secrets."wireguard_connection_1_peer_address" = { };
    sops.secrets."wireguard_connection_1_peer_port" = { };
    sops.secrets."wireguard_connection_1_psk" = { };
    sops.secrets."wireguard_connection_1_allowed_ips" = { };
    sops.secrets."wireguard_connection_1_ip" = { };
    sops.secrets."wireguard_connection_1_dns" = { };
    sops.secrets."wireguard_connection_1_search_domains" = { };
    sops.secrets."wireguard_connection_1_routes" = { };
    # Wireguard Network Connection 2:
    sops.secrets."wireguard_connection_2_private_key" = { };
    sops.secrets."wireguard_connection_2_peer_public_key" = { };
    sops.secrets."wireguard_connection_2_peer_address" = { };
    sops.secrets."wireguard_connection_2_peer_port" = { };
    sops.secrets."wireguard_connection_2_psk" = { };
    sops.secrets."wireguard_connection_2_allowed_ips" = { };
    sops.secrets."wireguard_connection_2_ip" = { };
    sops.secrets."wireguard_connection_2_dns" = { };
    sops.secrets."wireguard_connection_2_search_domains" = { };
    sops.secrets."wireguard_connection_2_routes" = { };

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
      hostName = "fw16-nix";
      hostId = "36a96503"; # FIXME required for ZFS. Should be unique.
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

        # Framework specific packages
        framework-tool
        linuxKernel.packages.linux_zen.framework-laptop-kmod
      ];
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch 0.0.5 https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#fw16-nix --impure";
    };

    services = {
      fprintd.enable = true;
      fwupd.enable = true;
      #pcscd.enable = true;
      power-profiles-daemon.enable = true;
      udev.packages = [ pkgs.via ];
    };
  }
