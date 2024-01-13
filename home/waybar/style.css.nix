{
  config,
  inputs,
  outputs,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/waybar/style.css" = {
    text = ''
      * {
          font-size: 12px;
          font-family: "Hack Nerd Font";
          border-radius: 10;
      }

      window#waybar {
        background-color: transparent;
        color: #${config.colorScheme.colors.base05};
        /* border-radius: 20px; */
        /* border: 1px solid #${config.colorScheme.colors.base00}; */
      }

      tooltip {
        background: #${config.colorScheme.colors.base00};
        border: 1px solid #${config.colorScheme.colors.base05};
        border-radius: 10px;
      }
      tooltip label {
        color: #${config.colorScheme.colors.base05};
      }

      #workspaces {
        background-color: transparent;
        margin-top: 0;
        margin-bottom: 0;
      }

      #workspaces button {
        background-color: #${config.colorScheme.colors.base00};
        color: #${config.colorScheme.colors.base05};
        border-radius: 10px;
        transition: all 0.3s ease;
        margin-right: 10;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background-color: #${config.colorScheme.colors.base04};
        color: #${config.colorScheme.colors.base09};
        min-width: 30px;
        transition: all 0.3s ease;
      }

      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${config.colorScheme.colors.base02};
        color: #${config.colorScheme.colors.base09};
        min-width: 30px;
        transition: all 0.3s ease;
        animation: colored-gradient 10s ease infinite;
      }

      /* #workspaces button.focused:hover,
      #workspaces button.active:hover {
        background-color: #${config.colorScheme.colors.base09};
        transition: all 1s ease;
      } */

      #workspaces button.urgent {
        background-color: #${config.colorScheme.colors.base0F};
        color: #${config.colorScheme.colors.base00};
        transition: all 0.3s ease;
      }

      /* #workspaces button.hidden {} */

      #taskbar {
        border-radius: 8px;
        margin-top: 4px;
        margin-bottom: 4px;
        margin-left: 1px;
        margin-right: 1px;
      }

      #taskbar button {
        color: #${config.colorScheme.colors.base05};
        padding: 1px 8px;
        margin-left: 1px;
        margin-right: 1px;
      }

      #taskbar button:hover {
        background: transparent;
        border: 1px solid #${config.colorScheme.colors.base02};
        border-radius: 8px;
        transition: all 0.3s ease;
        animation: colored-gradient 10s ease infinite;
      }

      /* #taskbar button.maximized {} */

      /* #taskbar button.minimized {} */

      #taskbar button.active {
        border: 1px solid #${config.colorScheme.colors.base02};
        border-radius: 8px;
        transition: all 0.3s ease;
        animation: colored-gradient 10s ease infinite;
      }

      /* #taskbar button.fullscreen {} */

      /* -------------------------------------------------------------------------------- */

      #custom-launcher,
      /* #window, */
      #submap
      #mode,
      /* #tray, */
      #cpu { background-color: #${config.colorScheme.colors.base00}; }
      #memory { background-color: #${config.colorScheme.colors.base00}; }
      #backlight,
      #window  { background-color: #${config.colorScheme.colors.base00}; }
      #pulseaudio.audio { background-color: #${config.colorScheme.colors.base00}; }
      #pulseaudio.microphone,
      #network { background-color: #${config.colorScheme.colors.base00}; }
      #bluetooth  { background-color: #${config.colorScheme.colors.base00}; }
      #battery  { background-color: #${config.colorScheme.colors.base00}; }
      #clock { background-color: #${config.colorScheme.colors.base00}; }
      #custom-powermenu,

      #custom-notification {
        background-color: transparent;
        color: #${config.colorScheme.colors.base05};
        padding: 1px 8px;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 2px;
        margin-right: 2px;
        border-radius: 20px;
        transition: all 0.3s ease;
      }

      #submap {
        background-color: #${config.colorScheme.colors.base00};
        border: 0;
      }

      /* If workspaces is the leftmost module, omit left margin */
      /* .modules-left > widget:first-child > #workspaces, */
      .modules-left > widget:first-child > #workspaces button,
      .modules-left > widget:first-child > #taskbar button,
      .modules-left > widget:first-child > #custom-launcher,
      .modules-left > widget:first-child > #window,
      .modules-left > widget:first-child > #tray,
      .modules-left > widget:first-child > #cpu,
      .modules-left > widget:first-child > #memory,
      .modules-left > widget:first-child > #backlight,
      .modules-left > widget:first-child > #pulseaudio.audio,
      .modules-left > widget:first-child > #pulseaudio.microphone,
      .modules-left > widget:first-child > #network,
      .modules-left > widget:first-child > #bluetooth,
      .modules-left > widget:first-child > #battery,
      .modules-left > widget:first-child > #clock,
      .modules-left > widget:first-child > #custom-powermenu,
      .modules-left > widget:first-child > #custom-notification {
        margin-left: 5px;
      }

      /* If workspaces is the rightmost module, omit right margin */
      /* .modules-right > widget:last-child > #workspaces, */
      /* .modules-right > widget:last-child > #workspaces, */
      .modules-right > widget:last-child > #workspaces button,
      .modules-right > widget:last-child > #taskbar button,
      .modules-right > widget:last-child > #custom-launcher,
      .modules-right > widget:last-child > #window,
      .modules-right > widget:last-child > #tray,
      .modules-right > widget:last-child > #cpu,
      .modules-right > widget:last-child > #memory,
      .modules-right > widget:last-child > #backlight,
      .modules-right > widget:last-child > #pulseaudio.audio,
      .modules-right > widget:last-child > #pulseaudio.microphone,
      .modules-right > widget:last-child > #network,
      .modules-right > widget:last-child > #bluetooth,
      .modules-right > widget:last-child > #battery,
      .modules-right > widget:last-child > #clock,
      .modules-right > widget:last-child > #custom-powermenu,
      .modules-right > widget:last-child > #custom-notification {
        margin-right: 5px;
      }

      /* -------------------------------------------------------------------------------- */

      #tray {
        background-color: #${config.colorScheme.colors.base00};
        padding: 1px 8px;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #${config.colorScheme.colors.base0F};
      }

    '';
  };
}
