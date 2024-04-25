{user, pkgs, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=,3840x2160,auto,1
      monitor=DP-2,3840x2160,0x0,1
      # Rotate DP-3 and place it to the left of DP-2
      monitor=DP-3,3840x2160,-2160x0,1,transform,1
    '';
  };

  environment.systemPackages = with pkgs; [
    age
    qmk
    qmk-udev-rules
    sops
  ];

  services = {
    fprintd.enable = true;
    fwupd.enable = true;
    #pcscd.enable = true;
    power-profiles-daemon.enable = true;
  }


}
