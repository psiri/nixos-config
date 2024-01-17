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
      ./per-device.nix # per device hypr configuration

      #./hardware-configuration.nix # machine hardware config
      /etc/nixos/hardware-configuration.nix
      ../standard.nix # standard or server configs

      #../../hardware/audio # change to pipewire, move to home
      #../../hardware/bluetooth
      #../../hardware/nvidia
      #../../hardware/rgb
      #../../hardware/wireless

      ../../home
      ../../home/barrier
      ../../home/bottom
      #../../home/codium
      #../../home/copyq
      ../../home/dunst
      #../../home/flameshot # Broken :(
      ../../home/firefox
      ../../home/git
      ../../home/gpg
      ../../home/hypr
      #../../home/kde
      ../../home/kitty
      ../../home/ulauncher
      #../../home/virt
      ../../home/waybar
      ../../home/gtk
      ../../home/wlogout
    ];

    colorscheme = inputs.nix-colors.colorSchemes.${scheme};
    home-manager.users.${user}.colorscheme = inputs.nix-colors.colorSchemes.${scheme};

    networking = {
      hostName = "desktop-nix";
      firewall.enable = true;
      networkmanager.enable = true;
    };

    hardware.opengl.enable = true;

    # services = {
    #   xserver = {
    #     enable = true;
    #   };
    # };

    environment = {
      #systemPackages = with pkgs; [pciutils];
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch 0.1 https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#desktop-nix --impure";
    };
  }
