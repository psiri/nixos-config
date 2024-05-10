# The defaut server configuration file.
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    ../home/vscode
    ../home/zsh
    ../modules/audio/disable.nix   # disable audio
    ../modules/console
    ../modules/virt
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well
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
        # docker
        unstable.okta-aws-cli # The unstable version of okta-aws-cli, and AWS CLI client for Okta SSO
      ];
    };
  };

  programs.htop.enable = true;
  # programs.htop.settings = {} # TODO - automatically configure htop
  # programs.virt-manager.enable
  programs.wireshark.enable = true;

  environment = {
    defaultPackages = [ pkgs.strace ]; # remove pearl and rsync
    shells = with pkgs; [zsh]; # default shell to zsh
    systemPackages = with pkgs; [
      ansible
      awscli2 # AWS CLI v2
      cifs-utils
      curl
      dig
      dnsutils
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      git
      gnutar # tar
      google-cloud-sdk
      hack-font
      htop
      iputils
      libsecret
      jq
      lshw # list hardware
      mtr
      nano
      neofetch
      netcat
      nix-zsh-completions
      nmap
      openssl
      python3
      python311Packages.boto3
      python311Packages.pip
      python311Packages.xmltodict
      ssm-session-manager-plugin # AWS Systems Manager Session Manager plugin
      terraform
      terraform-docs
      tree
      unzip
      wget
      wireshark
      zsh
      zsh-autocomplete
      zsh-history-substring-search
      zsh-nix-shell
      zsh-powerlevel10k
    ];
  };


  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system = {
    stateVersion = "24.05";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };
}