{user, ...}: {
  home-manager.users.${user}.home.file.".config/wlogout/layout" = {
    text = ''
      {
          "label" : "lock",
          "action" : "swaylock --fade-in 1 --effect-vignette 0.1:0.8",
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
