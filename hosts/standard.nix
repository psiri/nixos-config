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

    ../home
    ../home/bottom
    ../home/chrome
    ../home/dunst
    ../home/firefox
    #../home/flameshot            # Tested version broken on wayland :(
    ../home/git
    ../home/gpg
    ../home/gtk
    ../home/hypr
    ../home/joplin
    ../home/kitty
    ../home/obs-studio
    #../pkgs/pan-python
    #../home/swaylock             # replacing with hyprlock
    ../home/thunar                # file manager
    ../home/ulauncher
    ../home/vscode
    ../home/waybar
    ../home/wlogout
    ../home/zsh
    ../modules/audio/default.nix  # Standard audio module using pipewire
    ../modules/console
    ../modules/virt
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # import from ../overlays files
      #(import ../overlays/python)
      

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

  # Run garbage-collection weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  networking.firewall.enable = true;
  programs.mtr.enable = true;
  services.ntp.enable = true; # Enable NTP

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    timeout = 3;
  };

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

  home-manager.users.${user}.xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "$HOME/Desktop";
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots"; # Required so that grim can successfully save screenshots if the dir does not already exist
    };
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
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
      meslo-lgs-nf # powerlevel10k recommended font
      nerdfonts
      #(nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];
  };


  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.defaultUserShell = pkgs.zsh; # Set ZSH as the default shell for all users
  users.users = {
    ${user} = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      #initialPassword = "this-password-should-be-changed-as-soon-as-possible!";
      hashedPasswordFile = config.sops.secrets.user_password_hashed.path;
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager" "docker" "libvirtd" "plugdev"];
      packages = with pkgs; [
        # discord
        # docker
        # etcher          # Belena Etcher
        # flameshot       # ! Not yet working on Wayland :( TODO - revisit future release
        # gimme-aws-creds # CLI wrapper for Okta/ SAML2.0 IDPs and AWS
        # github-desktop
        gnome.file-roller # archive manager
        grim              # simple screenshot tool while flameshot is broken
        #input-leap
        #joplin-desktop
        kitty
        unstable.okta-aws-cli # The unstable version of okta-aws-cli, and AWS CLI client for Okta SSO
        # openconnect     # Open-source multi-VPN client supporting Cisco Anyconnect, Pulse Secure, GlobalProtect, etc
        # opensnitch      # Open-source application firewall
        remmina           # Open-source remote desktop client
        gnome.seahorse    # encryption key and password manager
        slack
        slurp             # used in conjunction with grim for screenshotting while flameshot is broken
        spotify
        # teams-for-linux # UNOFFICIAL MS Teams client, dropping this in favor of browser-based client
        # teamviewer
        vlc               # media player
        wl-clipboard      # tool for accessing Wayland clipboards
        zoom-us
        # TODO script SecureCRT install 
      ];
    };
  };

  programs.htop.enable = true;
  # programs.htop.settings = {} # TODO - automatically configure htop
  # programs.virt-manager.enable
  #programs.waybar.enable = true;
  programs.wireshark.enable = true;

  environment = {
    defaultPackages = [ pkgs.strace ]; # remove pearl and rsync
    sessionVariables = rec
    {
      #QT_QPA_PLATFORM = "wayland";
      #QT_QPA_PLATFORMTHEME = "qt5ct";
      #QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt6.qtbase}/lib/qt-6/plugins/platforms";
      GTK_THEME = "${config.colorscheme.slug}"; # sets default gtk theme the package built by nix-colors
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      NIXOS_OZONE_WL = "1"; # fixes electron apps in Wayland?
      XDG_SESSION_TYPE = "wayland";
      GIO_EXTRA_MODULES= lib.mkForce "${pkgs.gvfs}/lib/gio/modules:${pkgs.dconf.lib}/lib/gio/modules"; # Fix to get file managers (thunar, etc) to be able to mount SMB / CIFS / NFS and trash locations using gvfs
    };
    shells = with pkgs; [zsh]; # default shell to zsh
    systemPackages = with pkgs; [
      ansible
      awscli2 # AWS CLI v2
      brightnessctl
      cifs-utils
      curl
      dig
      dnsutils
      dunst
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      git
      gnutar # tar
      google-cloud-sdk
      hack-font
      htop
      iputils
      jq
      libsecret
      lshw # list hardware
      mtr  # better traceroute
      nano
      neofetch
      netcat
      nix-zsh-completions
      nmap
      openssl
      pinentry-all # needed for GPG
      pipewire
      polkit_gnome
      python3
      python311Packages.boto3
      python311Packages.pip
      #python311Packages.setuptools
      #python311Packages.virtualenv
      python311Packages.xmltodict
      #python311Packages.wheel
      #qt6.qtwayland # SecureCRT dependency
      ssm-session-manager-plugin # AWS Systems Manager Session Manager plugin
      #swayidle # Replaced with hyprlock
      #swaylock # Replaced with hypridle
      terraform
      terraform-docs
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


  services.teamviewer.enable = false;



  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  #system.stateVersion = "23.11";
  system = {
    stateVersion = "24.05";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };
}
