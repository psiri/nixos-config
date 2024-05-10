{
  disko.devices = {
    disk = {
      nv2280 = {
        type = "disk";
        # device = "/dev/disk/by-id/nvme-eui.";
        device = "/dev/nvme0n1"; # nvme0n1 is NVME 2280 slot on FW16 (with no 2230 active)
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zroot = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = ""; # not mirrored
        rootFsOptions = {
          canmount = "off";
        };
        # mountpoint = "/";
        postCreateHook = "(zfs list -t snapshot -H -o name | grep -E '^zroot/encrypted/root@blank$' || zfs snapshot zroot/encrypted/root@blank) && (zfs list -t snapshot -H -o name | grep -E '^zroot/encrypted/home@blank$' || zfs snapshot zroot/encrypted/home@blank)";
        datasets = {
          encrypted = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.encryption = "aes-256-gcm";
            options.keyformat = "passphrase";
            #options.keylocation = "file:///tmp/disk-1.key"; #TODO use nix-anywhere with --disk-encryption-keys
            postCreateHook = ''zfs set keylocation="prompt" "zroot/encrypted"''; # FIXME Prompts for password input. If you wish to have interactive-authentication, keep this line un-commented.  For fully-scripted installations using keyfiles, comment this option and uncomment "options.keylocation" instead.
          };
          "encrypted/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
          };
          "encrypted/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "legacy";
          };
          "encrypted/persist" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/persist";
          };
          "encrypted/home" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/home";
          };
        };
      };
    };
  };
  fileSystems = {
    "/".neededForBoot = true;
    "/nix".neededForBoot = true;
    "/home".neededForBoot = true;
    "/boot".neededForBoot = true;
    "/persist".neededForBoot = true;
  };
}
