{
  user,
  config,
  pkgs,
  ...
}: {
  home-manager.users.${user}.home.file.".config/wlogout/style.css" = {
    text = ''
      * {
        background-image: none;
      }

      window {
          font-family: Hack Nerd Font Mono;
          font-size: 72pt;
          color: #${config.colorScheme.palette.base06}; /* text */
          background-color: #${config.colorScheme.palette.base00};
      }

      button {
          color: #${config.colorScheme.palette.base05}; /*  text / nerdfont */
            background-color: #${config.colorScheme.palette.base01};
            border-style: solid;
            border-width: 3px;
            margin: 10px;
            border-radius: 10px;
            background-position: center;
          border-color: black;
            text-decoration-color: #FFFFFF;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:focus, button:active, button:hover {
          background-color: #${config.colorScheme.palette.base02};
          outline-style: none;
      }

      #lock {
      }

      #logout {
      }

      #suspend {
      }

      #hibernate {
      }

      #shutdown {
      }

      #reboot {
      }


    '';
  };
}
