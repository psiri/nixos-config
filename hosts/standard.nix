# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
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
    /etc/nixos/hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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

  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  networking.hostName = "unraid-nix";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  programs.mtr.enable = true;
  services.ntp.enable = true; # Enable NTP

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone="America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  # console.keyMap="us";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.defaultUserShell = pkgs.zsh; # Set ZSH as the default shell for all users
  users.users = {
    # FIXME: Replace with your username
    psiri = {
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

  environment.systemPackages = with pkgs; [
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
  programs.zsh.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.ohMyZsh.enable = true;
  # programs.zsh.ohMyZsh.plugins = [ ];  # TODO - add zsh plugins
  # programs.zsh.ohMyZsh.theme = [ ];  # TODO - add zsh theme
  programs.zsh.syntaxHighlighting.enable = true;
  # programs.zsh.syntaxHighlighting.highlighters = [ "main" ];
  # programs.zsh.syntaxHighlighting.patterns = [ "main" ];

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