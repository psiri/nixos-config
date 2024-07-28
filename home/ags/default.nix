{
  config,
  inputs,
  outputs,
  lib,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    programs.ags = {
      enable = true; # still need to enable the package
      configDir = ../ags; # sets to /home/${user}/.config/ags not 100% sure here :D
    };

    # works with shell scripts, will need to either write my own and symlink or write / declare in a .nix :)
    # can clone from git and place in the same dir, use home.file."foo.bar".source = ./foo.bar;

    home.file."./.config/ags/config.js".source = ./config.js;

    home.file.".config/ags/style.css" = {
      text = ''
            label {
            font-family: "Hasklug Nerd Font";
        }

        .workspaces button.focused {
            border-bottom: 3px solid #${config.colorScheme.palette.base05};
        }

        .client-title {
            margin-left: 1em;
            color: #${config.colorScheme.palette.base05};
        }

        .notification image {
            color: #${config.colorScheme.palette.base0F};
            margin-left: 1em;
        }

        .battery progressbar {
            margin: 0 6px;
        }

        .clock {
            margin: 0 6px;
            font-size: 1em;
        }

        progress, highlight {
            background-color: #${config.colorScheme.palette.base05};
            min-height: 8px;
        }
      '';
    };
  };
}
#      .workspaces button,
#      .media {
#          background-color: #${config.colorScheme.palette.base00};
#          color: #${config.colorScheme.palette.base05};
#      }
#
#      .workspaces button:hover,
#      .media:hover {
#          background-color: #${config.colorScheme.palette.base01};
#          color: #${config.colorScheme.palette.base05};
#      }
#      .workspaces button:active,
#      .media:active {
#          background-color: #${config.colorScheme.palette.base04};
#          color: #${config.colorScheme.palette.base05};
#      }

