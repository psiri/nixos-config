## Applications
| Function             | App                 |
| -------------------- | ------------------- |
| Application Launcher | ulauncher           |
| Archive Manager      | File-Roller         |
| Audio                | Pipewire            |
| Browser              | Chromium + Firefox  |
| Compositor           | Hyprland            |
| Display Server       | Wayland             |
| File Manager         | Thunar              |
| IDE                  | Codium (VS Code OSS)  |
| Idle Daemon          | hypridle            |
| Notes                | joplin-desktop      |
| Notifications        | dunst               |
| Screen Lock          | hyprlock            |
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

No matter how good our imperative toolsets were (and we've done some incredible things with Packer, Ansible, GitHub Actions, SSM, GCP OS Config, and the like), configuration drift of the hosts was inevitable (particularly after clients / end-users got ahold of these systems at runtime). Packer, GHA/Jenkins, and Ansible are great tools for AMI builds and initial configuration, but painfully slow (especially at scale), and (due to the nature of the tools being imperative) all have significant weaknesses when it comes to software they're was not explicitly instructed to manage. Extra software users manually-installed wouldn't be removed, and rectifying configuration drift between thse running (user-modified) systems' actual state and a desired ("golden") state was a constant struggle, especially when the goal is to ensure a host contains *only your specified/scanctioned/approved software* after end-users have got their hands on it.

Beyond the day-0 image build, we had no way to guarantee *an entire system* was still in its desired state. Sure, tools like these let us ensure *specified* packages, services, or agents were installed/removed, but everything else without one of these dedicated workflows fell into a grey area. No matter how tightly we locked-down the environment, it was virtually impossible to eliminate these problems without forcing users into something truly immutable - like Docker - and then shifting our security efforts "left".  While Docker is ideal for many production workloads/applications, it simply isn't a feasible replacement for user desktops / laptops / workstations. [WebTops](https://docs.linuxserver.io/images/docker-webtop/) come close, but still require a host system which in-turn must be built and maintained as well (making them better suited as a VDI alternative).

Along this journey I've spent ~30 years with Windows, 12+ years with MacOS, and 10+ years with Linux.  About 3 years ago I went all-in on Linux for my personal desktops / laptops (servers were already running linux). Initially I switched to Ubuntu (which I had worked with extensively, particulraly in the cloud), then to PopOS! (an Ubuntu-based distro by System76), then to Arch. In the case of both Ubuntu/Pop and Arch, I had also used Ansible for configuration management, but I could never quite get to the "ideal state" that I was looking for - *a declarative system backed by Infrastructure as Code (IaC) that ensured rock-solid stability, guaranteed reproducibility, and (ideally) immutability*. In addition, all these OSes had some issues with dependency conflicts, particularly when it became necessary to run multiple versions of software for development/testing purposes. I appreciated Debian-based distros' stability, software availability, and documentation, but frequently needed more up-to-date packages.  Arch checked the recent-software-availability box without sacrificing package availability or documentation quality, but being on the bleeding edge meant apps or system functionality would occasionally break during an update, and over time these stability issue collectively cost me a significant ammount of time as well.

### NixOS Journey

In late 2023 I discovered NixOS. NixOS promised to be the answer that I was looking for - it's declarative, code-driven, very hard to break (thanks to "generations" and its atomic operations), capable of adressing differing dependency issues seamlessly, and immutable (dev's claims - I'd actually argue it's not really "immutable" in the Docker sense, but in practice its atomic approach comes close enough while still maintaning usability). While I'm a security professional and **not a software developer**, I regularly work with enough Python, JSON, Terraform, etc. to quickly pick up the gist of the Nix language and hack together a working configuration.  I played around with NixOS in a few different "flavors" of VMs simulating servers, desktops, etc. (I would **strongly encourage** anyone looking to try NixOS to go this route before baremetal) until I had a fairly functional configuration, and then went about modularizing it using Nix flakes.

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

1. Clone the repo (optionally selecting target branch):
   1. `sudo git clone [--branch <YOURBRANCH>] https://github.com/psiri/nixos-config /tmp/dotfiles`
2. Change directory into the host-sepcific config dir. Example for host `fw16-nix`:
   1. `cd /tmp/dotfiles/hosts/fw16-nix`
3. Perform disk partitioning using disko:
    1. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko-config.nix`
    2. (Optional, recommended) Validate the partitioning
       1. run `mount | grep /mnt` and validate that the output shows your partitions as defined within the respective `disko-config.nix` file
<!-- 4.  Generate a temporary configuration.nix file without any filesystems:
    1.  `sudo nixos-generate-config --no-filesystems --root /mnt`
    2.  This will create the file `configuration.nix` in /mnt/etc/nixos
    3.  Copy the `disko-config.nix` file into `/etc/nixos`
        1.  `cp ./disko-config.nix /mnt/etc/nixos` -->
5.  Complete the NixOS installation:
    1.  Run `sudo nixos-install --flake /tmp/dotfiles/.#<HOSTNAME>` and reboot when the installation is complete
   

### Install or update from a running NixOS system:

1. Run `sudo nixos-rebuild switch --flake /tmp/dotfiles/.#<HOSTNAME>` to apply your system configuration.
    - Note: If you encounter an error, you may need to append the `--impure` flag




## Credits

Although I have finally taken the full Nix plunge (converting all my systems over to NixOs), I am still *very* new and tweaking my config daily.  Along the way I took inspiration (and referenced code) from the following resources:

* [Misterio77](https://github.com/Misterio77/nix-starter-configs) - Fantastic resource for starting out with Nixos flakes.  Well documented with many helpful inline-comments.
* [kye](https://codeberg.org/kye/nixos) - Absolutely beautiful Hyprland config with an intuitive, modular repo layout that can easily be adapted to your needs.


## Resources

The following are some of the NixOS resources I use constantly:

* [NixOS Package Search](https://search.nixos.org/packages?channel=23.11) - The quickest way to search for packages
* [NixOS Options Search](https://search.nixos.org/options?channel=23.11) - The quickest way to search for Nix configuration options you might care about
* [Home Manager Configuration Options](https://nix-community.github.io/home-manager/options.xhtml) - The official Home Manager configuration options documentation.  Contains all Home Manager options.