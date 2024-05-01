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
      ./hardware-configuration.nix
      ../standard.nix # standard or server configs

      ../../modules/virt
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
      ../../home/waybar
      ../../home/wlogout


      ./disko-config.nix
      ./impermanence.nix
      <sops-nix/modules/sops>
    ];

    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt"; # This is using an age key that is expected to already be in the filesystem
    sops.defaultSopsFormat = "yaml";
    sops.secrets.user_password_hashed.neededForUsers = true;
    sops.secrets."hello" = { };
    sops.secrets."psiri_hello" = { };
    #security.pam.services.${user}.enableKwallet = true;



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
      #systemPackages = with pkgs; [pciutils];
      shellAliases.rebuild = "sudo rm -rf /tmp/dotfiles && sudo git clone --branch 0.0.5 https://github.com/psiri/nixos-config /tmp/dotfiles && sudo nixos-rebuild switch --flake /tmp/dotfiles/.#fw16-nix --impure";
    };
  }
