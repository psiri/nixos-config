{user, ...}: {
  home-manager.users.${user}.home.file.".config/wlogout/layout" = {
    text = ''
      {
          "label" : "lock",
          "action" : "swaylock -c ff000000",
          "text" : "",
          "keybind" : "l"
      }
      {
          "label" : "reboot",
          "action" : "systemctl reboot",
          "text" : "󰜉",
          "keybind" : "r"
      }
      {
          "label" : "shutdown",
          "action" : "systemctl poweroff",
          "text" : "󰐥",
          "keybind" : "s"
      }
      {
          "label" : "logout",
          "action" : "hyprctl dispatch exit 0",
          "text" : "󰍃",
          "keybind" : "e"
      }
      {
          "label" : "suspend",
          "action" : "systemctl suspend",
          "text" : "󱖒",
          "keybind" : "u"
      }
      {
          "label" : "gem",
          "action" : "dunstify -a wlogout Gem_Activated",
          "text" : "󰮋",
          "keybind" : "q"
      }
    '';
  };
}
