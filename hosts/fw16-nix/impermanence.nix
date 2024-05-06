{
  #security.sudo.extraConfig = "Defaults lecture=never";
  system.activationScripts.createPersist = "mkdir -p /persist";
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/var/lib/bluetooth"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      #"/var/lib/sops-nix/key.txt"
    ];
    users.psiri = {
      directories = [
        ".cache"
        ".config"
        ".config/Spotify"
        ".config/Slack"
        ".config/Mozilla"
        ".config/sops/age"
        ".gnupg"
        ".local/share/remmina"
        ".local/share/ulauncher"
        ".local/state/home-manager"
        ".local/state/wireplumber"
        ".mozilla"
        ".okta"
        ".pki"
        ".ssh"
        ".terraform.d"
        ".vandyke"
        ".vscode-oss"
        ".zoom"
        ".zsh"
        "Desktop"
        "Documents"
        "Downloads"
        "JoplinBackup"
        "Music"
        "Pictures"
        "SecureCRT Logs"
        "Videos"
      ];
      files = [
        ".bash_history"
        #".gitconfig"
        #".zlogin"
        #".zshenv"
        #".zsh_history"
        #".zshrc"
      ];
    };
  };
}
