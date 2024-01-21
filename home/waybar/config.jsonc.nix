{
  config,
  inputs,
  outputs,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/waybar/config.jsonc" = {
    text = ''
      {
        "layer": "top",
        // "output": [],
        "position": "top",
        //"height": 16,    // blank = dynamic
        // "width": "",  // blank = dynamic
        // "margin": "", // margin value using the css format without units
        "margin-top": 2,
        "margin-bottom": 0,
        "margin-left": 10,
        "margin-right": 10,
        "spacing": 10,   // size of gaps between modules
        "gtk-layer-shell": true,
        "border-radius": 5,

        "clock": {
          "interval": 1,
          "format": " {:%I:%M:%S} ",
          "format-alt": " {:%A, %B %d %Y} ",
          // "on-click": "gnome-calendar",
          "tooltip": true,
          "tooltip-format": "{calendar}",
          "calendar": {
            "mode": "year",
            "mode-mon-col": 3,
            "format": {
              "today": "<span color='#${config.colorScheme.colors.base0F}'>{}</span>"
            }
          }
        },
        "modules-left": [
          "hyprland/workspaces",
          "custom/notification"
        ],
        "modules-center": [
          "clock"
          // "hyprland/submap",
          // "hyprland/window"
        ],
        "modules-right": [
          "network",
          "cpu",
          "memory",
          "bluetooth",
          "backlight",
          // "pulseaudio#microphone",
          "pulseaudio#audio",
          "battery",
          "tray"
        ],

        "hyprland/workspaces": {
          "format": "{name}: {icon} ",
          "format-icons": {
            "default": "󰄰",
            "active": ""
          },
          "on-click": "activate",
          "sort-by-number": true
        },

        "hyprland/submap": {
          "format": "{}",
          "tooltip": false
        },

        "hyprland/window": {
          "format": " {} ",
          "separate-outputs": false
        },

        "tray": {
          "icon-size": 12,
          "spacing": 5
        },

        "cpu": {
          "format": "  {usage}%",
          "interval": 1,
          "on-click": "",
          "tooltip": true,
          "tooltip-format": "Overall: {usage}%\n Load: {load}%\nAvg Freq: {avg_frequency} GHz\nMax Freq: {max_frequency} GHz\nMin Freq: {min_frequency} GHz\nCore 0: {usage0}%\nCore 1: {usage1}%\n Core 2: {usage2}%\n Core 3: {usage3}%\n Core 4: {usage4}%\n Core 5: {usage5}%\n Core 6: {usage6}%\n Core 7: {usage7}%"
        },

        "memory": {
          "format": "󰍛 {used:0.1f}GB ({percentage}%)", // "󰍛 {used:0.1f}GB ({percentage}%) / {total:0.1f}GB",
          "interval": 1,
          "on-click": "",
          "tooltip": true,
          "tooltip-format": "Used: {used} GiB ({percentage}%) / {total} GiB\nAvailable: {avail} GiB / {total} GiB\n Swap: {swapUsed} GiB ({swapPercentage}%) / {swapAvail} GiB"
        },

        "backlight": {
          "format": " {icon} {percent}% ",
          "format-icons": [
            "󰃟"
          ],
          "on-scroll-up": "brightnessctl set +1%",
          "on-scroll-down": "brightnessctl set 1%-",
          "on-click": "brightnessctl set 0",
          "tooltip": false
        },

        "pulseaudio#audio": {
          "format": " {icon} {volume:2} ",
          "format-bluetooth": " {icon} {volume}%  ",
          "format-muted": " {icon} Muted ",
          "format-icons": {
            "headphones": "",
            "default": [
              "",
              ""
            ]
          },
          "scroll-step": 5,
          "on-click": "pavucontrol",
          "on-click-right": "pamixer -t"
        },

        "network": {
          "interval": 1,
          // use auto-detection "interface": "wlp5s0",
          "format-icons": [
            "󰤯",
            "󰤟",
            "󰤢",
            "󰤥",
            "󰤨"
          ],
          "format-wifi": "󰞒 {bandwidthDownBytes} | 󰞕 {bandwidthUpBytes} {icon} {essid} ({signalStrength}%)",
          "format-disconnected": "", // empty format hides the module
          "format-disconnected": "󰤮",
          "format-ethernet": "󰞒 {bandwidthDownBytes} | 󰞕 {bandwidthUpBytes} {icon} {ifname} ", 
          "on-click": "kitty --class nmwui nmtui",
          "tooltip": true,
          "tooltip-format": "󰢮 {ifname}\n󰩟 {ipaddr}/{cidr}\n󰩟 Gateway: {gwaddr}\nNetmask: {netmask}\n{icon} {essid}\n󱑽 {signalStrength}% {signaldBm} dBm {frequency} MHz\n󰞒 {bandwidthDownBytes}\n󰞕 {bandwidthUpBytes}",
          "tooltip-format-disconnected": "Disconnected",
          "tooltip-format-disabled": "Disabled",
          "tooltip-format-ethernet": "󰢮 {ifname}\n󰩟 {ipaddr}/{cidr}\n󰩟 Gateway: {gwaddr}\nNetmask: {netmask}\n󰞒 {bandwidthDownBytes}\n󰞕 {bandwidthUpBytes}",
          "tooltip-format-wifi": "󰢮 {ifname}\n󰩟 {ipaddr}/{cidr}\n󰩟 Gateway: {gwaddr}\nNetmask: {netmask}\n{icon} {essid}\n󱑽 {signalStrength}% {signaldBm} dBm {frequency} MHz\n󰞒 {bandwidthDownBytes}\n󰞕 {bandwidthUpBytes}"
        },

        "bluetooth": {
          "format-disabled": " 󰂲 ",
          "format-off": " 󰂲 ",
          "format-on": " 󰂯 ",
          "format-connected": " 󰂯 ",
          "format-connected-battery": " 󰂯 ",
          "format-no-controller": "",
          "tooltip-format-connected": " {device_alias} 󰂄{device_battery_percentage} ",
          "on-click": "bluez",
          "tooltip": true
        },

        "battery": {
          "states": {
            "warning": 20,
            "critical": 10
          },

          "format": " {icon} {capacity} ",
          "format-charging": " 󰂄 {capacity} ",
          "format-plugged": " 󱘖 {capacity} ",
          "format-icons": [
            "󰁺",
            "󰁻",
            "󰁼",
            "󰁽",
            "󰁾",
            "󰁿",
            "󰂀",
            "󰂁",
            "󰂂",
            "󰁹"
          ],
          "on-click": "",
          "tooltip": false
        }
      }

    '';
  };
}
