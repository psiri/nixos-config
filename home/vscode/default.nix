{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.vscodium; # pkgs.vscodium or pkgs.vscode (default)
    
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
      #pkgs.vscode-extensions.bridgecrew.checkov                   # Does not exist, using workaround solution below
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.equinusocio.vsc-material-theme
      #pkgs.vscode-extensions.equinusocio.vsc-material-theme-icons # Does not exist
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.hashicorp.terraform
      pkgs.vscode-extensions.ms-azuretools.vscode-docker
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.ms-python.vscode-pylance
      pkgs.vscode-extensions.oderwat.indent-rainbow
      pkgs.vscode-extensions.pkief.material-icon-theme
      #pkgs.vscode-extensions.redhat.vscode-yaml
      #pkgs.vscode-extensions.redhat.vscode-xml
      #pkgs.vscode-extensions.shd101wyy.markdown-preview-enhanced
      pkgs.vscode-extensions.vscode-icons-team.vscode-icons
      pkgs.vscode-extensions.wholroyd.jinja
      pkgs.vscode-extensions.yzhang.markdown-all-in-one
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # TODO - Use below solution for installing missing extensions
      # Material Theme Icons (using another icon pack in the meantime)
      {
        name = "checkov";
        publisher = "bridgecrew";
        version = "1.0.98";
        sha256 = "38e1311f2cc71197d8a4dab9d36d9d53e19d9fb79b0c0df1737babbe253fd00c";
        # ! IMPORTANT ! The sha256 checksum is matched against the packages from the official visual studio marketplace
        # Download from https://marketplace.visualstudio.com/items?itemName=Bridgecrew.checkov (or your desired extension)
        # Then run the following command to determine the sha256 checksum:
        # sha256sum Bridgecrew.checkov-1.0.98.vsix 
      }
    ];
    globalSnippets = {};
    haskell.enable = false;
    keybindings = [];
    mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by VS Code
    userSettings = {};            # TODO - import settings from ~/.config/User/settings.json with solution for secret management
  };
}
