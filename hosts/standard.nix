# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  user,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    # /etc/nixos/hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # FIXME: Add the rest of the configuration that should be common across all hosts
  networking.firewall.enable = true;
  programs.mtr.enable = true;
  services.ntp.enable = true; # Enable NTP

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone="America/Los_Angeles";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  fonts = {
    fontconfig.defaultFonts.monospace = ["Hack Nerd Font Mono"];
    fontDir.enable = true;
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      hack-font
      material-design-icons
      material-symbols
      nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];
  };


  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.defaultUserShell = pkgs.zsh; # Set ZSH as the default shell for all users
  users.users = {
    ${user} = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "Coat-Wharf4-Pulverize";
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager" "docker"];
      packages = with pkgs; [
        # docker
        # etcher # Belena Etcher
        flameshot
        # gimme-aws-creds # CLI wrapper for Okta/ SAML2.0 IDPs and AWS
        github-desktop
        google-chrome
        joplin-desktop
        obs-studio
        # openconnect # Open-source multi-VPN client supporting Cisco Anyconnect, Pulse Secure, GlobalProtect, etc
        # opensnitch # Open-source application firewall
        remmina # Open-source remote desktop client
        slack
        spotify
        # teams-for-linux # UNOFFICIAL MS Teams client
        # teamviewer
        vlc
        vscode
        zoom-us
        # TODO script SecureCRT install
      ];
    };
  };

  programs.firefox.enable = true;
  # programs.firefox.policies # TODO - automatically install Firefox extensions
  programs.git.enable = true;
  # programs.git.config = [] # TODO - automatically configure gitconfig
  programs.htop.enable = true;
  # programs.htop.settings = {} # TODO - automatically configure htop
  programs.neovim.enable = true;
  # programs.neovim.configure = [] # TODO - automatically configure neovim
  # programs.virt-manager.enable
  programs.waybar.enable = true;
  programs.wireshark.enable = true;

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "line"];
    syntaxHighlighting.patterns = {};
    syntaxHighlighting.styles = {"globbing" = "none";};
    #promptInit = "info='n host cpu os wm sh n' fet.sh";
    ohMyZsh = {
      enable = true;
      theme = "ys"; # robbyrussel jnrowe muse obraun ys
      plugins = ["sudo" "terraform" "systemadmin" "vi-mode" "colorize"];
    };
  };

  environment = {
    sessionVariables = rec
    {
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      GTK_THEME = "${config.colorscheme.slug}"; # sets default gtk theme the package built by nix-colors
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      NIXOS_OZONE_WL = "1"; # fixes electron apps in Wayland?
      # TRYING THE BELOW!
      MOZ_ENABLE_WAYLAND=1;
      XDG_SESSION_TYPE = "wayland";
    };
    shells = with pkgs; [zsh]; # default shell to zsh
    systemPackages = with pkgs; [
      ansible
      awscli2 # AWS CLI v2
      curl
      dig
      dnsutils
      dunst
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      firefox
      git
      gnutar # tar
      hack-font
      htop
      iputils
      kitty
      libsecret
      lshw # list hardware
      mtr
      nano
      neofetch
      neovim
      netcat
      nix-zsh-completions
      nmap
      oh-my-zsh
      openssl
      pipewire
      polkit_gnome
      python3
      python311Packages.boto3
      python311Packages.pip
      python311Packages.xmltodict
      rofi
      ssm-session-manager-plugin # AWS Systems Manager Session Manager plugin
      swayidle
      swaylock
      terraform
      tree
      unzip
      usbutils # usb thing
      waybar
      wlogout
      wget
      wireshark
      zsh
      zsh-autocomplete
      zsh-history-substring-search
      zsh-nix-shell
      zsh-powerlevel10k
    ];
  };

  # services.opensnitch = {
  #   enable = false;
  #   # rules = {}
  #   settings = {
  #     DefaultAction = "allow";
  #     DefaultDuration = "until restart";
  #     Firewall = "iptables";
  #     ProcMonitorMethod = "ebpf"; # Set Opensnitch in EBPF mode
  #   };
  # };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    # jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.teamviewer.enable = false;


  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  # services.openssh = {
  #   enable = false;
  #   settings = {
  #     # Forbid root login through SSH.
  #     PermitRootLogin = "no";
  #     # Use keys only. Remove if you want to SSH using password (not recommended)
  #     PasswordAuthentication = false;
  #   };
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}