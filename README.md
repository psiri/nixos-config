## Instructions

0. (If running from the installer) Clone the configuration:
    1. `sudo git clone [--branch <YOURBRANCH>] https://github.com/psiri/nixos-config /etc/dotfiles`
    2. Change into the target tempalte subdirectory of the cloned dotfiles directory. 
        1.  Ex (`standard` template): `cd /etc/dotfiles/standard`

```
- Requirements: Nix 2.4+, and the experimental `flakes` and `nix-command` features:
```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

1.  Update any settings you currently have on `/etc/nixos/` to
  `nixos` (typically `configuration.nix` and `hardware-configuration.nix`).
    - The included file has some options you might want, specially if you don't
      have a configuration ready. Make sure you have generated your own
      `hardware-configuration.nix`; if not, just mount your partitions to
      `/mnt` and run: `nixos-generate-config --root /mnt`.
1. If you want to use home-manager: add your stuff from `~/.config/nixpkgs`
  to `home-manager` (probably `home.nix`).
  - The included file is also a good starting point if you don't have a config
    yet.
1. Take a look at `flake.nix`, making sure to fill out anything marked with
  FIXME (required) or TODO (usually tips or optional stuff you might want)

## Usage

- Run `sudo nixos-rebuild switch --flake .#hostname` to apply your system
  configuration.
    - If you're still on a live installation medium, run `nixos-install --flake
      .#hostname` instead, and reboot.
- Run `home-manager switch --flake .#username@hostname` to apply your home
  configuration.
  - If you don't have home-manager installed, try `nix shell nixpkgs#home-manager`.


