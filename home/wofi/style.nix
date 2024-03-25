#  css adapted from https://github.com/jsw08/dots/blob/master/modules/jsw_home/wofi/wofi/style.css
{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/wofi/style.css" = {
    text = ''
      window {
        margin: 5px;
        background-color: #${config.colorScheme.colors.base00};
        opacity: 1.0;
        font-size: 15px;
        font-family: JetBrainsMonoNL NF;
        border-radius: 10px;
        border: 5px solid #${config.colorScheme.colors.base03};
      }

      #outer-box {
        margin: 5px;
        border: 5px;
        border-radius: 10px;
      }

      #input {
        margin: 5px;
        background-color: #${config.colorScheme.colors.base01};
        color: #${config.colorScheme.colors.base05};
        font-size: 15px;
        border: 5px;
        border-radius: 10px;
      }

      #inner-box {
        background-color: #${config.colorScheme.colors.base00};
        border: 5px;
        border-radius: 10px;
      }

      #scroll {
        font-size: 15px;
        color: #${config.colorScheme.colors.base0F};
        margin: 10px;
        border-radius: 5px;
      }

      #scroll label {
        margin: 0px 0px;
      }

      #entry {
        margin: 5px;
        background-color: #${config.colorScheme.colors.base01};
        border-radius: 10px;
        border: 5px;
      }
      #entry:selected {
        background-color: #${config.colorScheme.colors.base02};
        border: 5px solid #${config.colorScheme.colors.base03};
        border-radius: 10px;
        border: 5px;
      }

      #img {
        margin: 5px;
        border-radius: 5px;
      }

      #text {
        margin: 2px;
        border: none;
        color: #${config.colorScheme.colors.base05};
      }
    '';
  };
}
