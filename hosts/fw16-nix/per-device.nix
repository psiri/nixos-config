{user, pkgs, ...}: {
  home-manager.users.${user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=eDP-1,2560x1600@60.00,0x0,1
      monitor=DP-2,3840x2160@143.98,auto,1
      # Rotate DP-3 and place it to the left of DP-2
      monitor=DP-3,3840x2160@60.00,auto,1,transform,1

      # trigger when the Lid Switch is turning on (lid closed)
      bindl = , switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
      # trigger when the Lid Switch is turning off (lid opened)
      bindl = , switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 2560x1600@60.00, 0x0, 1"
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
    udev.packages = [ pkgs.via ];
  };

}
