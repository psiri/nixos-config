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

      /etc/nixos/hardware-configuration.nix # machine-local hardware config (for initial setup)
      #./hardware-configuration.nix
      ../standard.nix # standard or server configs

      #../../hardware/audio # change to pipewire, move to home
      #../../hardware/bluetooth
      #../../hardware/nvidia
      #../../hardware/rgb
      #../../hardware/wireless

      ../../home
      #../../home/barrier # Does not support Wayland
      ../../home/bottom
      #../../home/codium
      #../../home/copyq
      ../../home/dunst
      #../../home/flameshot # Broken :(
      ../../home/firefox
      ../../home/git
      ../../home/gpg
      ../../home/gtk
      ../../home/hypr
      #../../home/input-leap
      #../../home/kde
      ../../home/kitty
      #../../home/rkvm
      ../../home/ulauncher
      #../../home/virt
      ../../home/waybar
      ../../home/wlogout
    ];

    colorscheme = inputs.nix-colors.colorSchemes.${scheme};
    home-manager.users.${user}.colorscheme = inputs.nix-colors.colorSchemes.${scheme};

    networking = {
      hostName = "ll-nix1";
      interfaces = {
        enp0s20f0u2 = {
          ipv4 = {
            addresses = [
              {
                address = "10.0.100.50";
                prefixLength = "24";
              }
            ];
            routes = [
              {
                address = "0.0.0.0";
                prefixLength = "0";
                via = "10.0.100.1";
              }
            ];
          };
        };
      };
      firewall.enable = true;
      networkmanager.enable = true;
    };

    hardware.opengl.enable = true;

    environment = {
      #systemPackages = with pkgs; [pciutils];
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch 0.1 https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#ll-nix1 --impure";
    };
  }
