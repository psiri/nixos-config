{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.vscode = {
    enable = true;
    enableExtensionsUpdateCheck = true;
    enableUpdateCheck = true;
    package = "pkgs.vscode"; # "pkgs.vscodium"
    extensions = [
      pkgs.vscode-extensions.soemthing.nix
    ];
    globalSnippets = {};
    haskell.enable = false;
    keybindings = [];
    mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by VS Code
    userSettings = {};
  };
}
