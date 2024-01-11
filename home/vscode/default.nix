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
    package = pkgs.vscode; # pkgs.vscodium
    
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
      #pkgs.vscode-extensions.bridgecrew.checkov
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.equinusocio.vsc-material-theme
      #pkgs.vscode-extensions.equinusocio.vsc-material-theme-icons
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
      # TODO - find solution for installing missing extensions
      # Checkov, Material Theme Icons (using another icon pack in the meantime)
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "checkov";
        publisher = "bridgecrew";
        version = "1.0.98";
        sha256 = "38e1311f2cc71197d8a4dab9d36d9d53e19d9fb79b0c0df1737babbe253fd00c"; # sha256sum ~/Downloads/Bridgecrew.checkov-1.0.98.vsix 
        # can be downloaded from https://marketplace.visualstudio.com/items?itemName=Bridgecrew.checkov
      }
    ];
    globalSnippets = {};
    haskell.enable = false;
    keybindings = [];
    mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by VS Code
    userSettings = {};
  };
}
