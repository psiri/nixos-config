{user, ...}: {
  home-manager.users.${user}.home.file.".config/wlogout/layout" = {
    text = ''
      {
          "label" : "lock",
          "action" : "pidof hyprlock || hyprlock",
          "text" : " Lock",
          "keybind" : "l"
      }
      {
          "label" : "reboot",
          "action" : "systemctl reboot",
          "text" : "󰜉 Reboot",
          "keybind" : "r"
      }
      {
          "label" : "shutdown",
          "action" : "systemctl poweroff",
          "text" : "󰐥 Shutdown",
          "keybind" : "s"
      }
      {
          "label" : "logout",
          "action" : "hyprctl dispatch exit 0",
          "text" : "󰍃 Logout",
          "keybind" : "e"
      }
      {
          "label" : "suspend",
          "action" : "systemctl suspend",
          "text" : "󱖒 Suspend",
          "keybind" : "u"
      }
      {
          "label" : "hibernate",
          "action" : "systemctl hibernate",
          "text" : "Hibernate",
          "keybind" : "h"
      }
    '';
  };
}
