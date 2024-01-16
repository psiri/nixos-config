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
      #window.titleBarStyle = "custom";  # ! IMPORTANT ! - this setting fixed vscode/codium crashing on launch under Wayland / Hyprland
      checkov = {
        checkovVersion = "latest";
        prismaURL = "https://api4.prismacloud.io";
        token = "";
        useBridgecrewIDs = true;
        useDebugLogs = true;
      };
      diffEditor = {
        ignoreTrimWhitespace = false;
      };
      editor = {
        cursorWidth = 2;
        fontFamily = "Hack Nerd Font";     
        fontLigatures = true;
        formatOnSave = true;
        formatOnSaveMode = "modificationsIfAvailable";
        minimap = {
          enabled = false;
        };
        renderControlCharacters = false;
        tabSize = 2;
        tokenColorCustomizations = {
          "[Material Theme Ocean High Contrast]" = {
            comments = "#5a5a5a";
            functions = "#b300ea";
            strings = "#19c1db";
            types = "#ff8000";
            textMateRules = [
              {
                "scope" = "storage.type.terraform";
                "settings" = {
                  "foreground" = "#ea7500";
                };
              }
              {
                "scope" = "punctuation.separator.terraform";
                "settings" = {
                  "foreground" = "#eeff02";
                };
              }
              {
                "scope" = "keyword.operator.accessor.terraform";
                "settings" = {
                  "foreground" = "#ff0000";
                };
              }
              {
                "scope" = "meta.block.terraform";
                "settings" = {
                  "foreground" = "#d18b8b";
                };
              }
              {
                "scope" = "support.constant.terraform";
                "settings" = {
                  "foreground" = "#726dff";
                };
              }
              {
                "scope" = "punctuation.section.parens.begin.terraform";
                "settings" = {
                  "foreground" = "#11fb00";
                };
              }
              {
                "scope" = "punctuation.section.parens.end.terraform";
                "settings" = {
                  "foreground" = "#11fb00";
                };
              }
              {
                "scope" = "punctuation.section.brackets.begin.terraform";
                "settings" = {
                  "foreground" = "#eafb00";
                };
              }
              {
                "scope" = "punctuation.section.brackets.end.terraform";
                "settings" = {
                  "foreground" = "#eafb00";
                };
              }
              {
                "scope" = "keyword.operator.logical.terraform";
                "settings" = {
                  "foreground" = "#eafb00";
                };
              }
              {
                "scope" = "entity.other.jinja.delimiter.variable";
                "settings" = {
                  "foreground" = "#e600ff";
                };
              }
              {
                "scope" = "punctuation.other.jinja";
                "settings" = {
                  "foreground" = "#eafb00";
                };
              }
              {
                "scope" = "punctuation.definition.string.begin.jinja";
                "settings" = {
                  "foreground" = "#ff0000";
                };
              }
              {
                "scope" = "punctuation.definition.string.end.jinja";
                "settings" = {
                  "foreground" = "#ff0000";
                };
              }
              {
                "scope" = "keyword.control.heredoc.terraform";
                "settings" = {
                  "foreground" = "#ff0000";
                };
              }
              {
                "scope" = "string.quoted.single.yaml";
                "settings" = {
                  "foreground" = "#7bd3ff";
                };
              }
            ];
          };
        };
        wordWrap = "on";
        wordWrapColumn = 120;
      },
      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };
      githubPullRequests = {
        pullBranch = "never";
      };
      materialTheme = {
        accent = "Teal";
      };
      prismaCloud = {
        assetDetails.AssetName = "vscode-iac-test";
        loginCredentials.AccessKey = "";
        loginCredentials.SecretKey = "";
        accessURL = "https://api4.prismacloud.io";
      };
      security = {
        workspace = {
          trust = {
            untrustedFiles = "open";
          };
        };
      };
      telemetry = {
        telemetryLevel = "off";
      };
      terminal = {
        external = {
          linuxExec = "zsh";
        };
        integrated = {
          cursorStyle = "line";
          defaultProfile = {
            osx = "zsh";
            linux = "zsh";
          };
          minimumContrastRatio = 1;
          persistentSessionScrollback = 1000;
          scrollback = 3000;
        };
      };
      terraform = {
        editor = {
          formatOnSave = true;
        };
        languageServer = {
          enable = true;
        };
        experimentalFeatures = {
          validateOnSave = true;
        };
      };
      window = {
        zoomLevel = 2;
      };
      workbench = {
        colorCustomizations = {
          activityBar = {
            activeBorder = "#80CBC4";
          };
          activityBarBadge = {
            background = "#80CBC4";
          };
          breadcrumb = {
            activeSelectionForeground = "#80CBC4";
          };
          editor = {
            findMatchBorder = "#80CBC4";
          };
          editorSuggestWidget = {
            highlightForeground = "#80CBC4";
          };
          editorWidget = {
            border = "#80CBC4";
            resizeBorder = "#80CBC4";
          };
          list = {
            activeSelectionForeground = "#80CBC4";
            highlightForeground = "#80CBC4";
            inactiveSelectionForeground = "#80CBC4";
          };
          menu = {
            selectionForeground = "#80CBC4";
          };
          menubar = {
            selectionForeground = "#80CBC4";
          };
          notificationLink = {
            foreground = "#80CBC4";
          };
          panelTitle = {
            activeBorder = "#80CBC4";
          };
          pickerGroup = {
            foreground = "#80CBC4";
          };
          progressBar = {
            background = "#80CBC4";
          };
          scrollbarSlider = {
            activeBackground = "#80CBC450";
          };
          selection = {
            background = "#80CBC4";
          };
          settings = {
            headerForeground = "#80CBC4";
            modifiedItemIndicator = "#80CBC4";
          };
          statusBarItem = {
            remoteBackground = "#80CBC4";
          };
          tab = {
            activeBorder = "#80CBC4";
          };
          textLink = {
            foreground = "#80CBC4";
          };
          "[Material Theme Ocean High Contrast]" = {
            activityBar = {
              activeBackground = "#081a1b";
              background = "#000000";
              foreground = "#ff0000";
            };
            editor = {
              background = "#000000";
              foreground = "#68007a";
            };
            sideBar = {
              background = "#000000";
              border = "#00828e";
              foreground = "#00fbff";
            };
            sideBarSectionHeader = {
              background = "#000000";
              foreground = "#00828e";
            };
            sideBarTitle = {
              foreground = "#77f9f9";
            };
            statusBar = {
              background = "#000000";
              border = "#000000";
              foreground = "#de6f00";
            };
            statusBarItem = {
              prominentForeground = "#e600ff";
            };
            tab = {
              activeBorder = "#ff0000";
              activeForeground = "#ff0000";
              activeBackground = "#00394f";
              inactiveForeground = "#c49af1";
              inactiveBackground = "#000000";
            };
            titleBar = {
              activeBackground = "#000000";
              activeForeground = "#77c3f9";
            };
          };
        };
        colorTheme = "Material Theme Ocean High Contrast";
        iconTheme = "vscode-icons";
        statusBar = {
          visible = true;
        };
      };
    };
  };
}
