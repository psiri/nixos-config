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
              "today": "<span color='#${config.colorScheme.palette.base0F}'>{}</span>"
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
          "power-profiles-daemon",
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
          "tooltip-format": "Used: {used} GiB ({percentage}%) / {total} GiB\nAvailable: {avail} GiB / {total} GiB\nSwap: {swapUsed} GiB ({swapPercentage}%) / {swapAvail} GiB"
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
          // use auto-detection. uncomment and specify to override "interface": "",
          "family": "ipv4_6",
          "format-wifi": "󰞒 {bandwidthDownBits} | 󰞕 {bandwidthUpBits} {icon} {essid} ({signalStrength}%)",
          "format-ethernet": "󰞒 {bandwidthDownBits} | 󰞕 {bandwidthUpBits} {icon} {ifname} ",
          "format-linked": "󰞒 {bandwidthDownBits} | 󰞕 {bandwidthUpBits} {icon} {ifname}",
          "format-disconnected": "󰤮",
          "format-disabled": "", // hide module
          "format-icons": {
            "wifi": [
              "󰤯",
              "󰤟",
              "󰤢",
              "󰤥",
              "󰤨"
            ],
            "ethernet": [
              "󰈀",
              "󰈀"
            ]
          },
          "on-click": "kitty --class nmwui nmtui",
          "tooltip": true,
          "tooltip-format-disconnected": "{icon} {ifname}\nStatus: Disconnected",
          "tooltip-format-disabled": "{icon} {ifname}\nStatus: Disabled",
          "tooltip-format": "{icon} {ifname}\nIPv4: {ipaddr}IPv4 CIDR: /{cidr}\nIPv4 Netmask: {netmask}\nIPv6 CIDR: {cidr6}\nIPv6 Netmask: /{netmask6}\nGateway: {gwaddr}\n{icon} {essid}\n󱑽 {signalStrength}% {signaldBm} dBm {frequency} GHz\n󰞒 {bandwidthDownBits}\n󰞕 {bandwidthUpBits}",
          "tooltip-format-ethernet": "{icon} {ifname}\nIPv4: {ipaddr}IPv4 CIDR: /{cidr}\nIPv4 Netmask: {netmask}\nIPv6 CIDR: {cidr6}\nIPv6 Netmask: /{netmask6}\nGateway: {gwaddr}\n󰞒 {bandwidthDownBits}\n󰞕 {bandwidthUpBits}",
          "tooltip-format-wifi": "{icon} {ifname}\nIPv4: {ipaddr}IPv4 CIDR: /{cidr}\nIPv4 Netmask: {netmask}\nIPv6 CIDR: {cidr6}\nIPv6 Netmask: /{netmask6}\nGateway: {gwaddr}\n{icon} {essid}\n󱑽 {signalStrength}% {signaldBm} dBm {frequency} GHz\n󰞒 {bandwidthDownBits}\n󰞕 {bandwidthUpBits}"
        },

        "bluetooth": {
          "format": "󰂲 {status}",
          "format-disabled": "󰂲 sw-disabled",
          "format-off": "󰂲 off",
          "format-on": "󰂯",
          "format-connected": "󰂯",
          "format-connected-battery": "󰂯",
          "format-no-controller": "󰂲 hw-disabled",
          "tooltip-format-connected": "{device_alias} 󰂄{device_battery_percentage}",
          "on-click": "bluez",
          "tooltip": false
        },

        "battery": {
          "interval": 60,
          "states": {
            "warning": 25,
            "critical": 15
          },

          "format": "{icon} {capacity}%",
          "format-charging": "󰂄 {capacity}% {time}",
          "format-plugged": "󱘖 {capacity}% {time}",
          "format-time": "{H} h {M} min",
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
          "tooltip": false,
          "tooltip-format": "{icon}\nCapacity: {capacity}\nTime to Full/Empty: {time}\nPower Draw (w): {power}\nCycles: {cycles}"
        },

        "power-profiles-daemon": {
          "format": "{icon}",
          "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
          "tooltip": true,
          "format-icons": {
            "default": "",
            "performance": "",
            "balanced": "",
            "power-saver": ""
          }
        }

      }

    '';
  };
}
