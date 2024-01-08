## Instructions

### Prerequisites
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
2. If you want to use home-manager: add your stuff from `~/.config/nixpkgs`
  to `home-manager` (probably `home.nix`).
  - The included file is also a good starting point if you don't have a config
    yet.
3. Take a look at `flake.nix`, making sure to fill out anything marked with
  FIXME (required) or TODO (usually tips or optional stuff you might want)


## Installation

### Install from minimal boot ISO

- Clone the nixos configuration:
    1. `sudo git clone [--branch <YOURBRANCH>] https://github.com/psiri/nixos-config /tmp/dotfiles`
       1. Note: `--branch <YOURBRANCH>` is optional but useful when testing new configurations that haven't been merged into main/master
    2. Copy the generated hardware configuration to your template directory:
          1. `cp /mnt/etc/nixos/hardware-configuration.nix /tmp/dotfiles/<TEMPLATE-NAME>/nixos/hardware-configuration.nix`
    3. Change into the mounted `nixos` location containing your generated `hardware-configuration.nix` (default = `/mnt/etc/nixos`). 
        1.  Ex (`standard` template): `cd /mnt/etc/nixos`
    4.  run `sudo nixos-install --flake /tmp/dotfiles/<TEMPLATE-NAME>.#hostname` and reboot when the installation is complete
   

### Install or customize from running NixOS installation

- Run `sudo nixos-rebuild switch --flake .#hostname` to apply your system
  configuration.
- Run `home-manager switch --flake .#username@hostname` to apply your home
  configuration.
  - If you don't have home-manager installed, try `nix shell nixpkgs#home-manager`.


