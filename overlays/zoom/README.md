# Zoom Overlay / Screen-Sharing Hack

## Description and Purpose

This file contains 2 unique overlays attempting to finally fix Zoom screen sharing under Wayland

1. **(CURRENTLY COMMENT-DISABLED)** Patching the Pipewire version back to 1.0.7 and the Zoom version back to "6.0.2.4680".
   * Zoom seems to specifically break with Pipewire 1.2.x +, this ensures Zoom uses an older Piperwire version while also pinning Zoom to a version known to work with screen sharing.
      * Note: if you want to use this method, you also need to add "pipewire-zoom" to your pkgs
2.  Tricking Zoom during package-build into thinking it's running under manjaro / gnome.  This hack enables multiple features (including screen-sharing) that Zoom now locks behind a smaller list of supported linux distros / desktops.
    *  This solution is meant to be used in conjunction with the only known current workaround - OBS "virtual cameras".  To enable OBS virtual cameras, add "zoom" and "obs-studio" to your packages, and set the following kernel modules to enable v4l2loopback:
```nix
boot = {
  extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  kernelModules = [ "v4l2loopback" ];
};
```


## Setting Up OBS v4l2loopback Virtual Camera for Zoom

1. Setup a new source (can be within a new scene or an existing) capturing your desktop. Typically this would be with a Pipewire screen capture. (you can re-select screens if needed once sharing)
2. Select "start virtual camera". Configure the virtual camera as follows:
   1. **Output Type: Source**
   2. **Output Selection: Screen Capture (Pipewire)**
   * Note: If you don't see the "start virtual camera" option under the "Controls" panel, you're likely missing one of the kernel modules mentioned above.


## Screen Sharing Your Virtual Camera in Zoom

1. Ensure the Virtual Camera created in OBS is running
   * When running, OBS will typically show a solid-blue highlight on the Virtual Camera option, and the test will change to "Stop Virtual Camera"
2. Launch Zoom
   * **Note:** depending how you've packaged zoom, you may need to launch as follows to trick zoom into thinking it's running on X11 under Gnome: `XDG_SESSION_TYPE=X11 XDG_CURRENT_DESKTOP=gnome zoom`
3. Select "Share"
4. On the "Advanced" tab, select "Content from 2nd Camera"