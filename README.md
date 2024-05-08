## Hosts

The following table breaks down the respective hardware and software / feature configuration of systems managed by this repo:

| Hostname                           |       Disko        |      sops-nix      |    Impermanence    |    Home-Manager    | Base Template                    | Hardware                              |
| ---------------------------------- | :----------------: | :----------------: | :----------------: | :----------------: | -------------------------------- | ------------------------------------- |
| [fw16-nix](./hosts/fw16-nix)       | :white_check_mark: | :white_check_mark: | :x:                | :white_check_mark: | [standard](./hosts/standard.nix) | Framework Laptop 16 (AMD, iGPU-only)  |
| [ll-nix1](./hosts/ll-nix1)         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | [standard](./hosts/standard.nix) | Dell Latitude (Intel, iGPU-only)      |
| [desktop-nix](./hosts/desktop-nix) | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | [standard](./hosts/standard.nix) | AMD Ryzen + AMD dGPU (custom build)   |
| [server-nix](./hosts/server-nix)   |        :x:         | :white_check_mark: |        :x:         | :white_check_mark: | [server](./hosts/server.nix)     | Intended for VMs (KVM, AWS, GCP, etc) |

## Applications
| Function             | App                                                        | Source Template(s) | Host(s)                                    |
| -------------------- | ---------------------------------------------------------- | ------------------ | ------------------------------------------ |
| Application Launcher | ulauncher                                                  |                    | fw16-nix, ll-nix1, desktop-nix             |
| Archive Manager      | File-Roller                                                |                    | fw16-nix, ll-nix1, desktop-nix             |
| Audio                | Pipewire, wireplumber                                      | standard           | fw16-nix, ll-nix1, desktop-nix             |
| Automation & IaC     | Ansible, Terraform                                         |                    | fw16-nix, ll-nix1, desktop-nix, server-nix |
| Browser              | Chromium, Firefox                                          | standard, server   | fw16-nix, ll-nix1, desktop-nix             |
| Collaboration Tools  | Slack, Zoom                                                | standard           | fw16-nix, ll-nix1, desktop-nix             |
| Compositor           | Hyprland                                                   |                    | fw16-nix, ll-nix1, desktop-nix             |
| CSP Tools            | AWS CLI (v2), google-cloud-sdk, SSM Session Manager plugin | standard, server   | fw16-nix, ll-nix1, desktop-nix, server-nix |
| Display Server       | Wayland                                                    |                    | fw16-nix, ll-nix1, desktop-nix             |
| File Manager         | Thunar                                                     |                    | fw16-nix, ll-nix1, desktop-nix             |
| IDE                  | Codium (VS Code OSS)                                       |                    | fw16-nix, ll-nix1, desktop-nix             |
| Idle Daemon          | hypridle                                                   |                    | fw16-nix, ll-nix1, desktop-nix             |
| Media Player         | spotify, vlc                                               | standard           | fw16-nix, ll-nix1, desktop-nix             |
| Network Tools        | dig, dnsutils, iputils, mtr, netcat, nmap, ntp, wireshark  |                    | fw16-nix, ll-nix1, desktop-nix             |
| Notes                | joplin-desktop                                             | standard           | fw16-nix, ll-nix1, desktop-nix             |
| Notifications        | dunst                                                      |                    | fw16-nix, ll-nix1, desktop-nix             |
| Screen Lock          | hyprlock                                                   |                    | fw16-nix, ll-nix1, desktop-nix             |
| Screen Recording     | OBS Studio                                                 |                    | fw16-nix, ll-nix1, desktop-nix             |
| Screenshots          | grim, slurp                                                | standard           | fw16-nix, ll-nix1, desktop-nix             |
| Session Management   | wlogout                                                    |                    | fw16-nix, ll-nix1, desktop-nix             |
| Shell                | zsh                                                        |                    | fw16-nix, ll-nix1, desktop-nix, server-nix |
| Status Bar           | Waybar                                                     |                    | fw16-nix, ll-nix1, desktop-nix             |
| System Monitor       | bashtop, bottom, htop                                      |                    | fw16-nix, ll-nix1, desktop-nix, server-nix |
| Terminal             | Kitty                                                      |                    | fw16-nix, ll-nix1, desktop-nix             |
| Text Editor          | nano                                                       |                    | fw16-nix, ll-nix1, desktop-nix, server-nix |
| Virtualization       | KVM, QEMU, vert-manager                                    | standard, server   | fw16-nix, ll-nix1, desktop-nix, server-nix |
| Window Manager       | Hyprland                                                   | standard           | fw16-nix, ll-nix1, desktop-nix             |


#### Repo Layout

The project blends some of the community's best-practices for repo layouts with lessons-learned from working with other modular automation tools (Ansible, Terraform, etc). It's layout is intended to enable systems to be configured in a flexible manner while minimizing code re-use and ensuring the end-state system isn't bloated.

Shared modules / components can be pulled-in at various levels as-appropriate:
1. Flake-level (applies to all systems)
2. Template-level
   * Applies to all systems which import the respective template - ex: headless-systems ([servers](./hosts/server.nix)) OR "[standard](./hosts/standard.nix)" / headed-systems (desktops, laptops)
3. Host-level (applies to a specific host)

```bash
.
├── flake.lock
├── flake.nix                          # Flake definition
├── home                               # Directory for user-specific apps and configurations. Contains both app-declarations and respective home-manager configurations. These directories are then imported as-needed by the "template" or per-host configurations.
│   ├── firefox                        # firefox package installation and home-manager config
│   │   └── default.nix
│   ├── hypr                           # Hyprland, Hypridle, and Hyprlock directory. Imported by hosts using the hypr ecosystem as compositor
│   │   ├── default.nix
│   │   ├── hypridle.nix
│   │   ├── hyprland.nix               # Hyprland home-manager config
│   │   ├── hyprlock.nix
│   │   └── hyprpaper.nix
│   └── example-app-3                  # Example - your additional apps would go here
│       └── default.nix
├── hosts                              # Directory containing templates (for server/headless and standard/headed) as well as per-host subdirectories           
│   ├── fw16-nix                       # Framework 16 host directory
│   │   ├── default.nix                # Defines host-specific config & imports the respective "template" (ex: "standard") + all host-specific config files (hardware-configuration.nix, per-device.nix, etc.)
│   │   ├── disko-config.nix           # Disko disk partitioning. Declares how disko will perform disk partitioning & file system config
│   │   ├── hardware-configuration.nix # Contains host-specific hardware configs. Ex: boot options, kernel modules, etc.
│   │   └── per-device.nix             # Per-host config customizations for hyprland (ex: monitor layouts, keybinds).
│   ├── your-new-host                  # Host-specific subdirectory for your new host would go here
│   │   ├── default.nix
│   │   ├── disko-config.nix
│   │   ├── hardware-configuration.nix
│   │   ├── impermanence.nix           # Impermanence configuration. Defines which files and folders will persist
│   │   └── per-device.nix
│   ├── server-nix                     # "server-nix" host directory
│   │   └── default.nix
│   ├── server.nix                     # Server (headless) template. Defines server baselines, imports other server apps as-needed
│   └── standard.nix                   # Standard (headed) configuration template.  Imports other standard apps as-needed
├── modules                            # Common momdules that may be imported / re-used by either templates or host-specific configs
│   ├── security-hardening
│   │   └── default.nix
│   └── virt                           # Virtualization module (KVM, qemu, vert-manager, etc)
│       └── default.nix
├── overlays                           # Overlay directory
│   └── default.nix                    # Default overlay allows for use of "unstable" packages when running "stable" channels, when required
├── pkgs                               # Custom package builds
│   └── securecrt
│       ├── default.nix
│       └── derivation.nix
├── README.md
└── secrets                            # Location of (encrypted) secrets what will be deployed and managed using sops-nix
│   └── secrets.yaml                   # assumes you are using the locally-managed secrets option instead of a private repo
└── .sops.yaml                         # Location of sops-nix configuration file (when using locally-managed secrets)
```


## Background

As a security / DevSecOps professional, I can't even begin to fathom the ammount of time I've wasted setting up systems for various clients or engagements, and how much collective effort I've invested into other "declarative" automation tools (Ansible, Chef, GCP "OS Config", AWS Systems Manager, etc.) trying to automate and scale both the build  and maintenance processes.  Over the course of my career I've ran numerous Professional Services (PS) teams, built and ran security-focused Managed Service (MS) offerings, and operated large-scale enterprise cloud platforms, but one of the toughest recurring challenges has always been management of hosts / endpoints - particularly in environments with strict security and/or compliance requirements.  

No matter how good our imperative toolsets were (and we've done some incredible things with Packer, Ansible, GitHub Actions, SSM, GCP OS Config, and the like), configuration drift of the hosts was inevitable (particularly after clients / end-users got ahold of these systems at runtime). Packer, GHA/Jenkins, and Ansible are great tools for AMI builds and initial configuration, but painfully slow (especially at scale), and (due to the nature of the tools being imperative) all have significant weaknesses when it comes to software they're not explicitly-instructed to manage. Extra software users manually-installed wouldn't be removed, and rectifying configuration drift between thse running (user-modified) systems' actual state and a desired ("golden") state was a constant struggle, especially when the goal is to ensure a host contains *only your specified/scanctioned/approved software*.

Beyond the day-0 image build, we had no way to guarantee *an entire system* was still in its desired state. Sure, tools like these let us ensure *specified* packages, services, or agents were installed/removed, but everything else without one of these dedicated workflows fell into a grey area. No matter how tightly we locked-down the environment, it was virtually impossible to eliminate these problems without forcing users into something truly immutable - like Docker - and then shifting our security efforts "left".  While Docker is ideal for many production workloads/applications, it simply isn't a feasible replacement for user desktops / laptops / workstations. [WebTops](https://docs.linuxserver.io/images/docker-webtop/) come close, but still require a host system which in-turn must be built and maintained as well (making them better suited as a VDI alternative).

### NixOS Journey

Along this journey I've spent ~30 years with Windows, 12+ years with MacOS, and 10+ years with Linux.  About 3 years ago I went all-in on Linux for my personal desktops / laptops (servers were already running linux). Initially I switched to Ubuntu (which I had worked with extensively, particulraly in the cloud), then to PopOS! (an Ubuntu-based distro by System76), then to Arch. In the case of both Ubuntu/Pop and Arch, I had also used Ansible for configuration management, but I could never quite get to the "ideal state" that I was looking for - *a declarative system backed by Infrastructure as Code (IaC) that ensured rock-solid stability, guaranteed reproducibility, and (ideally) immutability*. In addition, all these OSes had some issues with dependency conflicts, particularly when it became necessary to run multiple versions of software for development/testing purposes. I appreciated Debian-based distros' stability, software availability, and documentation, but frequently needed more up-to-date packages.  Arch checked the recent-software-availability box without sacrificing package availability or documentation quality, but being on the bleeding edge meant apps or system functionality would occasionally break during an update, and over time these stability issue collectively cost me a significant ammount of time as well.

In 2023 I discovered NixOS. NixOS promised to be the answer that I was looking for - it's declarative, code-driven, very hard to break (thanks to "generations" and its atomic operations), capable of adressing differing dependency issues seamlessly, and immutable (dev's claims - I'd actually argue it's not really "immutable" in the Docker sense, but in practice its atomic approach comes close enough while still maintaning usability). While I'm a security professional and **not a software developer**, I regularly work with enough Python, JSON, Terraform, etc. to quickly pick up the gist of the Nix language and hack together a working configuration.  I played around with NixOS in a few different "flavors" of VMs simulating servers, desktops, etc. (I would **strongly encourage** anyone looking to try NixOS to go this route before baremetal) until I had a fairly functional configuration, and then went about modularizing it using Nix flakes.

### This Project

This repo represents the continuiously-evolving state of my _personal_ NixOS systems.  This project uses the modern NixOS "flakes" approach to modularize system and software configurations.  At this time, the configuration is intended for single-user systems, though I have attempted to varibleize the user-specific elements / home-manager components for future support of multi-user systems.
NixOS has a pretty steep learning curve, and along my joruney I've leaned heavily on the great work of others to get to this point.  I fully support/encourage anyone looking for NixOS reference configurations to borrow code from this project (if you do, please just reference me).


### Project Goals

* **Modular / Multi-Purpose:**
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
1. Requirements: Nix 2.4+
2. The experimental `flakes` and `nix-command` features
3. `git`


## Installation
This section describes how to install NixOS.

### Install From a Boot ISO:

Note: Any installation ISO will work, but I chose minimal to ensure the configuration can be easily replicated onto headless systems. For most users, the Gnome ISO will be the recommended choice, as also simplifies network connections and comes with `git` pre-installed.

The instructions below assume you will be using flakes, [disko](https://github.com/nix-community/disko) for declarative disk partitioning, `home-manager` for declarative home management, and [sops-nix](https://github.com/Mic92/sops-nix) for secrets management. [Impermanence](https://github.com/nix-community/impermanence) (included on most of my systems now) is optional, but can easily be turned off with a few comments.

1. Clone the repo (optionally selecting target branch):
   1. `sudo git clone [--branch <YOUR-TARGET-BRANCH>] https://github.com/psiri/nixos-config`
      *   **Note:** `--branch <YOUR-TARGET-BRANCH>` is optional but useful when testing new configurations that haven't been merged into main/master. I regularly use this method to ensure the entire rebuild process can be thoroughly tested and vetted against prior to a merge into main/master.  Alternatively you can checkout your desired branch once cloned.
2. Perform disk partitioning using disko:
    * :warning: WARNING: :warning: These operations are destructive.
    1. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./nixos-config/hosts/<HOSTNAME>/disko-config.nix`
       * **Note:** if you did not specify a key file for disk encryption, you may be prompted to specify your encryption passphrase 
    2. (Optional, recommended) Validate the partitioning
       1. run `mount | grep /mnt` and validate that the output shows your partitions as defined within the respective `disko-config.nix` file
    3. :bangbang: :construction: :bangbang:**(REQUIRED IF USING SOPS SECRETS FOR INITIAL USER PASSWORDS)**: Ensure the sops-nix (private) key is imported to the target path.
        1. The specific location depends on what you've defined for sops in the `sops.age.keyFile` option. 
           1. Ex: `~/.config/sops/age/keys.txt`
           2. Ex (with impermanence): ```/persist/var/lib/sops-nix/key.txt```
3.  Complete the NixOS installation:
    1.  Run `sudo nixos-install --flake ./nixos-config/.#<HOSTNAME>` and reboot when the installation is complete
        * :notebook_with_decorative_cover: **Note:** Depending whether you opted to store secrets locally or in a private get repo, you may be prompted for authentication to the private repo
   

## Updates
This section describes how yo update your NixOS configuration.

### Update from a running NixOS system:

1. Change directory into the configuration repo:
   - `cd nixos-config`
2.  :lock: **(Required only when secrets stored in a private repo have been updated):** Ensure your flake's lock is updated to point to the latest private-secrets repo's commit:
    1. :information_source: If you are not using secrets stored in a separate, private repo, OR these secrets have not been updated, you may skip this step
    2. Run the following command to ensure `flake.lock` points to the latest commit in your private secrets repo.  In the exmaple below, it is assumed your private-secrets input matches the example created in [Option 2 - Sops-Nix with Secrets Stored in a Private Repo](#option-2---sops-nix-with-secrets-stored-in-a-private-repo)
       1. ```nix flake lock --update-input private-secrets```
3.  Run `sudo nixos-rebuild switch --flake ./.#<HOSTNAME>` to apply your system configuration.
    - **Note:** If you encounter an error that your  config is "dirty", you may need to append the `--impure` flag


## Secret Management with Sops-Nix

This section describes how to (safely) manage secrets declaratively using sops-nix, and provides examples for both managing secrets in a public repository (along with your configuration) or separately in a private repository (my personal recommendation for added security). 

### Sops-Nix Prerequisites

The example below is intended to get you up-and-running with sops-nix in the simpliest, most intuitive way possible. While I do recommend using deriving your age keys from ed25519 keys for enhanced security, the steps below will allow beginners to quickly achieve fully-declarative management of secrets.

1. (If necessary) Generate a key using age:
   1. `mkdir -p ~/.config/sops/age`
   2. `age-keygen -o ~/.config/sops/age/keys.txt`
      1. When using age, the public key will be output from this command.  This will be required for the next step.
2. Copy your age PUBLIC key into a `.sops.yaml` file
   1. Paste your PUBLIC key under the `keys` list.  For a user with name `bob`, an example would be:
    ```yaml
    # .sops.yaml
    #
    # This example uses YAML anchors which allows reuse of multiple keys without having to repeat yourself.
    # Also see https://github.com/Mic92/dotfiles/blob/master/nixos/.sops.yaml for a more complex example.
    keys:
      - &bob 2504791468b153b8a3963cc97ba53d1919c5dfd4
    creation_rules:
      - path_regex: secrets/[^/]+\.(yaml|json|env|ini)$
        key_groups:
        - age:
          - *bob
    ```
    * **Note:** the location of this file will depend on whether you are storing secrets locally (in the same repo as your config), or in a separate private repository (as described in the following section).
      * For an example of the resulting file using local encryption, see [.sops.yaml](.sops.yaml)
      * For details on using a separate private repo, see [Option 2 - Sops-Nix with Secrets Stored in a Private Repo](#option-2---sops-nix-with-secrets-stored-in-a-private-repo)
3. After configuring .sops.yaml, you can open a new secrets file with sops:
   1. `nix-shell -p sops --run "sops secrets/secrets.yaml"`
      1. Define the secrets (optionally with a hierarchy). Once saved, the contents will be encrypted with sops-nix and safe for commitment to VCS.
      * For an example of the resulting encrypted file, see [./secrets/secrets.yaml](secrets/secrets.yaml)
4. For _each_ secret the host requires, you will need a corresponding secret declaration in the form of `sops.secrets."SECRET-NAME" = { };`
     * [Example:](./hosts/fw16-nix/default.nix#L58) ```sops.secrets."hello_world" = { }; # Example secret. Will be mounted at /run/secrets/hello_world```
     * If specifying secrets for users, the special flag `neededForUsers = true;` must be set on the corresponding secret. This will cause the secret to be mounted at `/run/secrets-for-users` such that it can be utilized during initial user creation.
      * Example can be seen in [./hosts/fw16-nix/default.nix line 57](./hosts/fw16-nix/default.nix#L57):
         * ```sops.secrets.user_password_hashed.neededForUsers = true;```

#### Option 1 - Sops-Nix with Secrets Stored Locally (In the Same Repo)

You are now ready to deploy your secrets to your machine. If you are satisfied using the local-repository to store your (encrypted) secrets, proceed as follows:

5. To deploy your secrets, simply run a rebuild!
   1. `sudo nixos-rebuild switch --flake ./nixos-config/.#<HOSTNAME>`


#### Option 2 - Sops-Nix with Secrets Stored in a Private Repo

You are now ready to deploy your secrets to your machine.  If you are particularly security-conscious (like me), or your organization has secutiy and/or compliance standards prohibiting storage of secrets in VCS (even if they are encrypted), you can store sops-nix secrets in a separate private repository.  

The following steps describe how deploy secrets stored in a (separate) private repo. It is assumed that you have completed the [Sops-Nix Prerequisites](#sops-nix-prerequisites) and already generated your `.sops.yaml` and `secrets.yaml` files:

5. Create a private repository to store your secrets.
   * In my case, I created the following repo: `https://github.com/psiri/nixos-secrets`
6. The repository needs only contain the `.sops.yaml` and `secrets.yaml` files generated in the prerequisites steps above.  
   1. Move the `.sops.yaml` and (encrypted) `secrets.yaml` files into the private repo.  A basic repo structure may look as follows:
    ```bash
   .
   ├── README.md
   ├── secrets
   │   └── secrets.yaml
   └── .sops.yaml
    ```
7. Add the following lines to `inputs` within `flake.nix` to tell NixOS where to pull your private secrets from:
   ```nix
   # ./flake.nix

   private-secrets = {
      url = "git+https://github.com/psiri/nixos-secrets.git?ref=main&shallow=1"; # Private repo used to store secrets separately with an added layer of protection. Replace with your respective repo URL. "&shallow=1" is added to ensure Nix only grabs the latest commit.
      # url = "git+ssh://github.com/psiri/nixos-secrets.git?ref=main&shallow=1"; # Alternatively, you can clone using SSH
      flake = false;
   };
   ```
    * For a working reference example, refer to: [flake.nix](./flake.nix#L33-L37)
8. Update the `sops.defaultSopsFile` setting to point to the private repository
   1. ```sops.defaultSopsFile = "${builtins.toString inputs.private-secrets}/secrets.yaml";```
      1. For a working reference example, refer to: [hosts/fw16-nix/default.nix](./hosts/fw16-nix/default.nix#L61-L68)
   * **Note:** When building for the first time, you will be prompted for authentication to the private repo.  While you can use basic authentication, a PAT is recommended.  Alternatively, you can also clone using SSH.
   * **Note:** If there are changes to the repo, run `nix flake lock --update-input private-secrets` to ensure the flake is update to point to the latest commit


## Disko

This section describes how to use disko for declarative disk layout, partitioning, and file system configuration.  

[Disko](https://github.com/nix-community/disko) is a NixOS flake aimed at closing the gaps in what Nix does not natively manage declaratively - disk partitioning and formatting.  Disko is especially useful for enabling fully-automated, unattended installations where no human interraction is possible.

Currently disko supports:

   * **Disk layouts:** GPT, MBR, and mixed.
   * **Partition tools:** LVM, mdadm, LUKS, and more.
   * **Filesystems:** ext4, btrfs, ZFS, bcachefs, tmpfs, and others.


#### Configure Disko

1. Add disko to your [`flake.nix` inputs and outputs:](./flake.nix#L4-L53)
   ```nix
   # ./flake.nix

   inputs = { 
      # ... omitted for brevity
      disko = {
         url = "github:nix-community/disko";
         inputs.nixpkgs.follows = "nixpkgs";
      };
   }

   outputs = {
      # ... omitted for brevity
      disko,
      ...
   }
   ```
2. Call the disko module from your respective [nixosConfigurations in flake.nix](./flake.nix#L88-L172)
   ```nix
   # ./flake.nix

   fw16-nix = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
      system = "x86_64-Linux";
      modules = [
         ./hosts/fw16-nix                             # > Our host-specific nixos configuration file <
         disko.nixosModules.disko                     # Calls the disko module
         sops-nix.nixosModules.sops
         hardware.nixosModules.framework-16-7040-amd
         impermanence.nixosModules.impermanence       
      ];
   };
   ```
3. Define your disk configuration declaratively. In virtually any real-world scanario, this will be done on a host-by-host basis, thus I'd recommend placing the respective configuration within the host-specific subdirectory (`./hosts/HOSTNAME/disko-config.nix`).
   * :information_source: [Disko quickstart guide](https://github.com/nix-community/disko/blob/master/docs/quickstart.md)
   * :information_source: For reference configurations specific to your selected disk layout, parition scheme, and file systems, refer to [disko's official example configurations](https://github.com/nix-community/disko/tree/master/example)
   * :notebook_with_decorative_cover: For a working example of my configuration (encrypted ZFS with datasets for /, /persist, /nix, and /home) refer to: [./hosts/fw16-nix/disko-config.nix](./hosts/fw16-nix/disko-config.nix)
   * :warning: Depending on your chosen filesystem (ZFS and BTRFS specifically), you may need to take extra steps to ensure your configuration defines an initial "blank" snapshot.  The `postCreateHook` suboption can be useful for doing this declaratively: 
      ```nix
      # ./hosts/HOSTNAME/disko-config.nix

      psstCreateHook = "(zfs list -t snapshot -H -o name | grep -E '^zroot/encrypted/root@blank$' || zfs snapshot zroot/encrypted/root@blank) && (zfs list -t snapshot -H -o name | grep -E '^zroot/encrypted/home@blank$' || zfs snapshot zroot/encrypted/home@blank)";
      ``` 
   * :exclamation: Although the above solution enables disko to automatically create the blank snapshot(s), for non-tmpfs filesystems you will also need a means by which to ensure the filesystem(s) are reverted to this blank snapshot every boot. If you are interested in configuring impermanence, see [Impermanence Prerequisites](#impermanence-prerequisites) below for details on how to achieve root filesystem wipes. 


## Impermanence

This section describes how to enable impermanence.  

[Impermanence](https://github.com/nix-community/impermanence) is a NixOS flake which aims to make your system (_almost_ completely) ephemeral.  Impermanence is implemented in conjunction with a means of wiping or "rolling back" your system configuration such that all files and directories you don't explicitly declare as "persistent" are wiped out every reboot.


#### Impermanence Prerequisites
To configure impermanence, you will need need the following, at minimum:

1. At least one mounted volume where the files and directories you want to keep are stored permanently.
   * In our case, the ZFS dataset (encrypted/persist) mounted at `/persist` will satisfy this requirement. Reference config: [./hosts/fw16-nix/disko-config.nix](./hosts/fw16-nix/disko-config.nix#L59-L63)
   ```nix
   # ./hosts/HOSTNAME/disko-config.nix

   "encrypted/persist" = {
      type = "zfs_fs";
      options.mountpoint = "legacy";
      mountpoint = "/persist";
   };
   ```
2. At least one of the modules in the disko repository, which take care of linking or bind mounting files between the persistent storage mount point and the root file system
   * In our case, we will import the disko flake. Configuration details are provided in the next section.
3. A root filesystem which somehow gets wiped on reboot.
   * :warning: The method of deletion / rollback depends on your filesystem and hardware configuration.
   1. Ensure your host automatically wipes or reverts its root filesystem (at minimum) every boot.  Refer to the examples below depending on your filesystem:
        * [BTRFS using subvolumes](https://github.com/nix-community/impermanence?tab=readme-ov-file#btrfs-subvolumes)
        * [ZFS using snapshot rollback](./hosts/fw16-nix/hardware-configuration.nix#L17-L38) (current method employed by this repo)
          * In the examples contained within this repo, ZFS snapshot rollbacks are utilized to return the root dataset back to its initial (pristine) state. This snapshot is taken right after disko initially partitions the drives and creates filesystems, as described in [Configure Disko Step #3](#configure-disko).
        * [root on tmpfs](https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/) (Easiest implementation, but has some drawbacks - particularly on systems with limited RAM. I would recommend one of the others)


#### Configure Impermanence
With the prerequisites satisfied, perform the following steps to configure impermanence:

1. Add impermanence to your [`flake.nix` inputs and outputs:](./flake.nix#L4-L53)
      ```nix
      # ./flake.nix

      inputs = { 
         # ... omitted for brevity
         impermanence.url = "github:nix-community/impermanence";
      }

      outputs = {
         # ... omitted for brevity
         impermanence,
         ...
      }
      ```
2. Call the module from your respective [nixosConfigurations in flake.nix](./flake.nix#L88-L172)
   ```nix
   # ./flake.nix

   fw16-nix = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit nix-colors user plymouth_theme inputs outputs;};
      system = "x86_64-Linux";
      modules = [
         ./hosts/fw16-nix                             # > Our host-specific nixos configuration file <
         disko.nixosModules.disko                     
         sops-nix.nixosModules.sops
         hardware.nixosModules.framework-16-7040-amd
         impermanence.nixosModules.impermanence       # Calls the impermanence module
      ];
   };
   ```
3. Define the directories and files which will be marked as persistent
   * While you could technically define a single impermanence configuration to be used across multiple hosts (for example, at the template level), unless the software setup is identical on each, it's more practical to define an individual config for each host.
   1. Create an `impermanence.nix` file to define persistent files and directories:
      1. Set the path to your persistent volume.  In the example below,  the path is `/persist`, which was created by `disko` as defined in `./hosts/HOSTNAME/disko-config.nix`
      ```nix
      # ./hosts/HOSTNAME/impermanence.nix

      {
         system.activationScripts.createPersist = "mkdir -p /persist";
         environment.persistence."/persist" = {
         # ... omitted 
         };
      }
      ```
      2. Within the `environment.persistence."<YOUR-PERSIST-PATH>"` value, you can now declare which directories and files will persist (survive the data wipe / rollback). 
         * The `environment.persistence."<YOUR-PERSIST-PATH>".users.<USERNAME>` option also allows you to set persistence for the user's home directory. Paths defined under this option are automatically prefixed with with the user’s home directory.
             * For a working example, refer to [impermanence.nix](./hosts/desktop-nix/impermanence.nix.nix)
         * :information_source: Refer to the [official impermanence module documentation](https://github.com/nix-community/impermanence?tab=readme-ov-file#module-usage) for additional details
4. Whever appropriate, import the [impermanence.nix](./hosts/desktop-nix/impermanence.nix.nix) config file you just created.
   * The example below assumes you have created a per-host `impermance.nix` file within the host-specific subdirectory.  
   ```nix
   # ./hosts/HOSTNAME/default.nix

   imports = [
      # ... omitted for brevity
      ./disko-config.nix
      ./impermanence.nix # host-specific impermanence config. Located at ./hosts/HOSTNAME/impermanence.nix
   ];
   ```

#### Test / Validate Impermanence
After configuring impermanence and rebuilding, you can validate impermanence is functioning properly with the following simple test:

1. Create (any) dummy / test file within the root filesystem
   1. ```sudo touch /impermanence-validation-test.txt```
2. Reboot your system
3. Ensure the dummy / test file has been deleted
   1. ls / 

#### Troubleshooting Impermanence
If your validation test failed, try the following:
* (ZFS) Ensure that disko successfully created the blank root snapshot:
  * `zfs list -t snapshot` should display (at least) the blank root snapshot created by the `disko-config.nix` we created in [Configure Disko Step #3](#configure-disko):
  ```bash
   NAME                         USED  AVAIL  REFER  MOUNTPOINT
   zroot/encrypted/home@blank    95K      -    98K  -
   zroot/encrypted/root@blank    95K      -    98K  -
  ```
* (ZFS / BTRFS) Ensure that your configuration contains the necessary customization for automatically rolling-back your snapshot / deleting root, as covered in [Impermanence Prerequisites](#impermanence-prerequisites).
  * :information_source: I personally had the config defined, but initially missed the simple `boot.initrd.systemd.enable = lib.mkDefault true;` option, so systemd never actually ran the rollback script!
* (ZFS / BTRFS) Ensure that your rollback / root-wipe script is successfully executed at boot:
  * Examine journalctl logs.
   ```
   psiri@fw16-nix  ~  sudo journalctl
   # ... omitted
   May 02 19:50:14 localhost systemd[1]: Starting Rollback root filesystem to a pristine state on boot...
   May 02 19:50:14 localhost rollback-start[668]:   >> >> rollback complete << <<
   May 02 19:50:14 localhost systemd[1]: rollback.service: Deactivated successfully.
   May 02 19:50:14 localhost systemd[1]: Finished Rollback root filesystem to a pristine state on boot.
   ```
  * :notebook_with_decorative_cover: If your rollback script contians a message or description, you can simply grep for that. Otherwise it's easiest to use `sudo journalctl | grep "rollback.service"` or `sudo journalctl | grep "Finished Rollback"` to confirm.

## Credits

Although I have finally taken the full Nix plunge (converting all my systems over to NixOs), I am still new and tweaking my config daily.  Along the way I took inspiration (and referenced code) from the following resources:

* :link: [Misterio77](https://github.com/Misterio77/nix-starter-configs) - Fantastic resource for starting out with Nixos flakes.  Well documented with many helpful inline-comments.
* :link: [kye](https://codeberg.org/kye/nixos) - Absolutely beautiful Hyprland config with an intuitive, modular repo layout that can easily be adapted to your needs.


## Resources

The following are some of the NixOS resources I use constantly:

* :link: [NixOS Package Search](https://search.nixos.org/packages?channel=23.11) - The quickest way to search for packages
* :link: [NixOS Options Search](https://search.nixos.org/options?channel=23.11) - The quickest way to search for Nix configuration options you might care about
* :link: [Home Manager Configuration Options](https://nix-community.github.io/home-manager/options.xhtml) - The official Home Manager configuration options documentation.  Contains all Home Manager options.
* :link: [disko](https://github.com/nix-community/disko) - Official nix-community flake for declarative disk configuration with examples for virtually any disk / partition / file system combination you'd be interested in.
* :link: [sops-nix](https://github.com/Mic92/sops-nix) - The best option for declarative, version-control-ready secrets management on NixOS.
* :link: [Impermanence](https://github.com/nix-community/impermanence) - Official nix-community flake for creating ephemeral (impermanent) NixOS systems. Supports opt-in state persistence for critical files and directories.
* :link: [erase-your-darlings blog by grahamc](https://grahamc.com/blog/erase-your-darlings) - Fantastic blog on immpermanence with ZFS.
