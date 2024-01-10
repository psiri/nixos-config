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
          font-size: 200pt;
          color: #${config.colorscheme.colors.base06}; /* text */
          background-color: #${config.colorscheme.colors.base00};
      }

      button {
          color: #${config.colorscheme.colors.base05}; /* text / nerdfont */
      	  background-color: #${config.colorscheme.colors.base01};
      	  border-style: none;
      	  border-width: 10px;
          margin: 20px;
          border-radius: 10px;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:focus, button:active, button:hover {
      	  background-color: #${config.colorscheme.colors.base02};
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

      #gem {
      }

    '';
  };
}
