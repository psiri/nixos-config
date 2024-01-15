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
      # Use below example solution for installing other missing extensions
      # TODO - Material Theme Icons (using another icon pack in the meantime)
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
    userSettings = {
      editor.minimap.enabled = false;
      window.titleBarStyle = "custom";  # ! IMPORTANT ! - this setting fixed vscode/codium crashing on launch under Wayland / Hyprland
      workbench.colorTheme = "Material Theme Ocean High Contrast";
      workbench.statusBar.visible = true;
      workbench.colorCustomizations = {
        activityBarBadge.background = "#80CBC4";
        activityBar.activeBorder = "#80CBC4";
        list.activeSelectionForeground = "#80CBC4";
        list.inactiveSelectionForeground = "#80CBC4";
        list.highlightForeground = "#80CBC4";
        scrollbarSlider.activeBackground = "#80CBC450";
        editorSuggestWidget.highlightForeground = "#80CBC4";
        textLink.foreground = "#80CBC4";
        progressBar.background = "#80CBC4";
        pickerGroup.foreground = "#80CBC4";
        tab.activeBorder = "#80CBC4";
        notificationLink.foreground = "#80CBC4";
        editorWidget.resizeBorder = "#80CBC4";
        editorWidget.border = "#80CBC4";
        settings.modifiedItemIndicator = "#80CBC4";
        settings.headerForeground = "#80CBC4";
        panelTitle.activeBorder = "#80CBC4";
        breadcrumb.activeSelectionForeground = "#80CBC4";
        menu.selectionForeground = "#80CBC4";
        menubar.selectionForeground = "#80CBC4";
        editor.findMatchBorder = "#80CBC4";
        selection.background = "#80CBC4";
        statusBarItem.remoteBackground = "#80CBC4";
        "[Material Theme Ocean High Contrast]" = {
            activityBar.background = "#000000";
            activityBar.foreground = "#ff0000";
            tab.activeBorder = "#ff0000";
            tab.activeForeground = "#ff0000";
            tab.activeBackground = "#00394f";
            tab.inactiveForeground = "#c49af1";
            tab.inactiveBackground = "#000000";
            titleBar.activeForeground = "#77c3f9";
            titleBar.activeBackground = "#000000";
            activityBar.activeBackground = "#081a1b";
            editor.background = "#000000";
            editorLineNumber.foreground = "#68007a";
            sideBar.background = "#000000";
            sideBar.border = "#00828e";
            sideBar.foreground = "#00fbff";
            sideBarSectionHeader.background = "#000000";
            sideBarSectionHeader.foreground = "#00828e";
            sideBarTitle.foreground = "#77f9f9";
            statusBar.background = "#000000";
            statusBar.border = "#000000";
            statusBar.foreground = "#de6f00";
            statusBarItem.prominentForeground = "#e600ff";
        };
      };
      materialTheme.accent = "Teal";
      editor.fontFamily = "OperatorMono";
      editor.wordWrap = "on";
      editor.wordWrapColumn = 120;
      editor.cursorWidth = 2;
      editor.fontLigatures = true;
      #editor.tokenColorCustomizations = {} # TODO
      git.autofetch = true;
      editor.renderControlCharacters = false;
      "[terraform]" = {
          editor.formatOnSave = true;
      };
      editor.tabSize = 2;
      editor.formatOnSave = true;
      prismaCloud.assetDetails.AssetName = "vscode-iac-test";
      prismaCloud.loginCredentials.AccessKey = "";
      prismaCloud.loginCredentials.SecretKey = "";
      prismaCloud.accessURL = "https://api4.prismacloud.io";
      checkov.token = "";
      checkov.prismaURL = "https://api4.prismacloud.io";
      checkov.useBridgecrewIDs = true;
      checkov.checkovVersion = "latest";
      checkov.useDebugLogs = true;
      git.enableSmartCommit = true;
      git.confirmSync = false;
      terminal.integrated.minimumContrastRatio = 1;
      terminal.integrated.defaultProfile.osx = "zsh";
      telemetry.telemetryLevel = "off";
      workbench.iconTheme = "eq-material-theme-icons";
      terminal.integrated.scrollback = 3000;
      diffEditor.ignoreTrimWhitespace = false;
      terraform.languageServer.enable = true;
      editor.formatOnSaveMode = "modificationsIfAvailable";
      terraform.experimentalFeatures.validateOnSave = true;
      githubPullRequests.pullBranch = "never";
      terminal.external.linuxExec = "zsh";
      terminal.integrated.cursorStyle = "line";
      terminal.integrated.defaultProfile.linux = "zsh";
      terminal.integrated.persistentSessionScrollback = 1000;
      security.workspace.trust.untrustedFiles = "open";
      window.zoomLevel = 2;
    };
  };
}
