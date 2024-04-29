{user, pkgs, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      # Desktop middle monitor
      monitor=DP-1,3840x2160@60,auto,1.5
      # Desktop left monitor
      monitor=DP-2,3840x2160@60,auto,1.5,transform,1
      # monitor=DP-2,disable
      # Built-in display
      monitor=eDP-1,preferred,auto,1
      #monitor=eDP-1,disable
    '';
  };

  environment.systemPackages = with pkgs; [
    age
    qmk
    qmk-udev-rules
    sops
    # Necessary for Gnome to use the ambient light sensor
    iio-sensor-proxy
    # Framework specific bits
    framework-tool
    linuxKernel.packages.linux_zen.framework-laptop-kmod
  ];

  services = {
    fprintd.enable = true;
    fwupd.enable = true;
    #pcscd.enable = true;
    #power-profiles-daemon.enable = true;
    udev.packages = [ pkgs.via ];
  };

}
