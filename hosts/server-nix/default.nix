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

      #./hardware-configuration.nix # machine hardware config
      /etc/nixos/hardware-configuration.nix
      ../server.nix # standard or server configs

      ../../home
      ../../home/bottom
      ../../home/firefox
      ../../home/git
      ../../home/gpg
      ../../home/kitty
      #../../home/virt
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


    colorscheme = inputs.nix-colors.colorSchemes.${scheme};
    home-manager.users.${user}.colorscheme = inputs.nix-colors.colorSchemes.${scheme};

    networking = {
      hostName = "server-nix";
      hostId = "62ca471b"; # FIXME required for ZFS. Should be unique.
      firewall.enable = true;
      networkmanager.enable = true;
    };

    environment = {
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch main https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#server-nix --impure";
    };
  }
