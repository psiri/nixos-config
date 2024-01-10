## Applications
| Function             | App                 |
| -------------------- | ------------------- |
| Application Launcher | Rofi                |
| Audio                | Pipewire            |
| Display Server       | Wayland             |
| IDE                  | Visual Studio Code  |
| Notifications        | dunst               |
| Screen Lock          | swaylock & swayidle |
| Screen Recording     | OBS Studio          |
| Screenshots          | Flameshot           |
| Session Management   | wlogout             |
| Shell                | zsh                 |
| Status Bar           | Waybar              |
| Terminal             | Kitty               |
| Text Editor          | Neovim              |
| Window Manager       | Hyprland            |

## Instructions

### Prerequisites
- Requirements: Nix 2.4+
- The experimental `flakes` and `nix-command` features

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

1.  Update any settings you currently have on `/etc/nixos/` to
  `nixos` (typically `configuration.nix` and `hardware-configuration.nix`).
    - The included file has some options you might want, specially if you don't
      have a configuration ready. Make sure you have generated your own
      `hardware-configuration.nix`; if not, just mount your partitions to
      `/mnt` and run: `nixos-generate-config --root /mnt`.
2. If you want to use home-manager: add your stuff from `~/.config/nixpkgs`
  to `home`. These configurations are imported as-needed by the user-and-hsot
1. Take a look at `flake.nix`, making sure to fill out anything marked with
  FIXME (required) or TODO (usually tips or optional stuff you might want)
1. Clone the nixos configuration:
    1. `sudo git clone [--branch <YOURBRANCH>] https://github.com/psiri/nixos-config /tmp/dotfiles`
       1. Note: `--branch <YOURBRANCH>` is optional but useful when testing new configurations that haven't been merged into main/master

## Installation

### Install from minimal boot ISO:

1. Run through the [official NixOS install guide](https://nixos.wiki/wiki/NixOS_Installation_Guide), STOPPING after completing the `NixOs Config` step
2. Copy the generated hardware configuration to your template directory:
    1. `cp /mnt/etc/nixos/hardware-configuration.nix /tmp/dotfiles/hosts/<HOSTNAME>/hardware-configuration.nix`
3.  run `sudo nixos-install --flake /tmp/dotfiles/.#<HOSTNAME>` and reboot when the installation is complete
   

### Install or customize from a running NixOS system:

1. Run `sudo nixos-rebuild switch --flake /tmp/dotfiles/.#<HOSTNAME>` to apply your system configuration.
    - Note: If you encounter an error, you may need to append the `--impure` flag
2. (OPTIONAL) If you don't have home-manager installed, run `nix shell '<home-manager>' -A install` to install using nix-shell
3. Run `home-manager switch --flake /tmp/dotfiles/.#USERNAME@<HOSTNAME>` to apply your home configuration via home-manager.


