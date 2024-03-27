## Applications
| Function             | App                 |
| -------------------- | ------------------- |
| Application Launcher | ulauncher           |
| Archive Manager      | File-Roller         |
| Audio                | Pipewire            |
| Display Server       | Wayland             |
| File Manager         | Thunar              |
| IDE                  | Visual Studio Code  |
| Notes                | joplin-desktop      |
| Notifications        | dunst               |
| Screen Lock          | swaylock & swayidle |
| Screen Recording     | OBS Studio          |
| Screenshots          | grim + slurp        |
| Session Management   | wlogout             |
| Shell                | zsh                 |
| Status Bar           | Waybar              |
| System Monitor       | bashtop + bottom + htop |
| Terminal             | Kitty               |
| Text Editor          | nano                |
| Virtualization       | KVM + QEMU + vert-manager |
| Window Manager       | Hyprland            |

## Background

As a security / DevSecOps professional, I can't even begin to fathom the ammount of time I've wasted setting up systems for various clients or engagements, and how much collective effort I've invested into other "declarative" automation tools (Ansible, Chef, GCP "OS Config", AWS Systems Manager, etc.) trying to automate and scale both the build  and maintenance processes.  Over the course of my career I've ran numerous Professional Services (PS) teams, built and ran security-focused Managed Service (MS) offerings, and operated large-scale enterprise cloud platforms, but one of the toughest recurring challenges has always been management of hosts / endpoints.  

No matter how good our imperative toolsets were (and we've done some incredible things with Ansible, GitHub Actions, SSM, and the like), configuration drift of the hosts was inevitable (particularly after clients / end-users got ahold of these systems), and beyond the day-0 image build, we had no way to guarantee a system was in a given state. No matter how tightly we locked-down the environment, it was virtually impossible to eliminate the these problems without forcing users into Docker.  While Docker is ideal for production workloads/applications, it simply isn't quite feasible for user desktops / laptops / VDI. ([WebTops](https://docs.linuxserver.io/images/docker-webtop/) come very close here but persistence necessitating image-rebuilds becomes the limiting factor)

Along this journey I've spent ~30 years with Windows, 12+ years with MacOS, and 10+ years with Linux.  About 3 years ago I went all-in on Linux for my personal desktops / laptops (servers were already running linux). Initially I switched to Ubuntu (which I had worked with extensively, particulraly in the cloud), then to PopOS! (an Ubuntu-based distro by System76), then to Arch.  In the case of both Ubuntu/Pop and Arch, I had also used Ansible for configuration management, but I could never get to the "ideal state" that I was looking for - *a truly declarative system backed by declarative Infrastructure as Code (IaC) that ensured rock-solid stability, reproducibility, and (ideally) immutability (or close to it)*.  Ansible was great for initial provisioning and system-hardening, but (due to the nature of the tool being imperative) anything that was not explicitly contianed in the ansible roles was untouched - extra software woulnd't be removed, missing software (not defined in Ansible roles) wasn't installed, and I was constantly tyring to rectify drift between systems' actual and desired-state.  In addition, all these OSes had some issues with dependency conflicts, particularly when it became necessary to run multiple versions software for development/testing.  I appreciated Debian-based distros' stability, software availability, and documentation, but occasionally needed more up-to-date packages.  Arch checked the recent-software-version box without sacrificing package availability or documentation quality, but as a result would periodically break some apps or system functionality that (collectively) cost me a lot of time.

### NixOS Journey

In late 2023 I discovered NixOS. NixOS promised to be the answer that I was seeking - it's declarative, code-driven, very hard to break (thanks to "generations" and its atomic operations), capable of adressing differing dependency issues seamlessly, and immutable (dev's claims - I'd actually argue it's not really "immutable" in the Docker sense, but in practice comes close enough while still being usable). While I'm first and foremost a security professional and **not a software developer**, I regularly work with enough Python, JSON, Terraform, etc. to quickly pick up the gist of the Nix language and hack together a working configuration.  I played around with NixOS in a few different "flavors" of VMs simulating servers, desktops, etc. (I would **strongly encourage** anyone looking to try NixOS to go this route before baremetal) until I had a fairly functional configuration, and then went about modularizing it using Nix flakes.

### This Project

This repo represents the continuiously-evolving state of my _personal_ NixOS systems.  This project uses the modern NixOS "flakes" approach to modularize system and software configurations.  At this time, the configuration is intended for single-user systems, though I have attempted to varibleize the user-specific elements / home-manager components for future support of multi-user systems.
NixOS has a pretty steep learning curve, and along my joruney I've leaned heavily on the great work of others to get to this point.  I fully support/encourage anyone looking for NixOS reference configurations to borrow code from this project (if you do, please just reference me).

#### Repo Layout

The project blends some of the community's best-practices for repo layouts with lessons-learned from working with other modular automation tools (Ansible, Terraform, etc). It's layout is intended to enable systems to be configured in a flexible manner while minimizing code re-use and ensuring the end-state system isn't bloated.

Shared modules / components can be pulled-in at various levels as-appropriate:
1. Flake-level (applies to all systems)
2. Template-level (applies to all systems of a given template / flavor - ex: headless-systems [servers], headed-systems [desktops, laptops])
3. Host-level (applies to a specific host)

### Project Goals

* **Multi-Purpose:**
  * Servers / headless systems (both physical and cloud-hosted)
  * Desktops
  * Laptops
* **Minimal:**
  * Keep the total package count as low as possible; strip out everything that isn't required
  * Minimize vulnerabilities
  * Keep attack surface as small as possible
  * Remain lightweight (a nice side-effect but not the main focus)
* **Hardened:**
  * Strong network-security
    * Host-firewall enabled. Explicit ingress firewall rules, and *only* when absolutely necessary (server deployments, etc)
    * TO-DO: Application firewall (opensnitch or similar)
  * TO-DO: CIS benchmark hardening (level 1 + 2 if possible)
  * Long-term desire for high-degree of DISA STIG compliance
    * Note: Until there are NixOS-specific STIGs, map to generic Linux controls

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
       1. Note: `--branch <YOURBRANCH>` is optional but useful when testing new configurations that haven't been merged into main/master. I regularly use this method to ensure the entire rebuild process can be thoroughly tested and vetted against prior to a merge into main/master.

## Installation

### Install from minimal boot ISO:

Note: Any installation ISO will work, but I chose minimal to ensure the configuration can be easily replicated onto headless systems

1. Run through the [official NixOS install guide](https://nixos.wiki/wiki/NixOS_Installation_Guide), STOPPING after completing the `NixOs Config` step
2. Copy the generated hardware configuration to your template directory:
    1. `cp /mnt/etc/nixos/hardware-configuration.nix /tmp/dotfiles/hosts/<HOSTNAME>/hardware-configuration.nix`
3.  run `sudo nixos-install --flake /tmp/dotfiles/.#<HOSTNAME>` and reboot when the installation is complete
   

### Install or update from a running NixOS system:

1. Run `sudo nixos-rebuild switch --flake /tmp/dotfiles/.#<HOSTNAME>` to apply your system configuration.
    - Note: If you encounter an error, you may need to append the `--impure` flag




## Credits

Although I have finally taken the full Nix plunge (converting all my systems over to NixOs), I am still *very* new and tweaking my config daily.  Along the way I took inspiration (and referenced code) from the following resources:

* [Misterio77](https://github.com/Misterio77/nix-starter-configs) - Fantastic resource for starting out with Nixos flakes.  Well documented with many helpful inline-comments.
* [kye](https://codeberg.org/kye/nixos) - Absolutely beautiful Hyprland config with an intuitive, modular repo layout that can easily be adapted to your needs.