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

      #../../hardware/bluetooth

      ../../home
      ../../home/bottom
      ../../home/firefox
      ../../home/git
      ../../home/gpg
      ../../home/kitty
      #../../home/virt
    ];

    colorscheme = inputs.nix-colors.colorSchemes.${scheme};
    home-manager.users.${user}.colorscheme = inputs.nix-colors.colorSchemes.${scheme};

    networking = {
      hostName = "server-nix";
      firewall.enable = true;
      networkmanager.enable = true;
    };

    environment = {
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch main https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#server-nix --impure";
    };
  }
