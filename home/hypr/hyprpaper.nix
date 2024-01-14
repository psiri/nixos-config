{
  config,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/hypr/hyprpaper.conf" = {
    text = ''
      preload = ~/Pictures/Wallpaper/5.jpg
      preload = ~/Pictures/Wallpaper/6.jpg
      preload = ~/Pictures/Wallpaper/7.jpg
      preload = ~/Pictures/Wallpaper/8.jpg

      wallpaper = eDP-1, ~/Pictures/Wallpaper/5.jpg
    '';
    # wallpaper = eDP-1, ~/nixos/wallpaper/5.jpg
    # this value needs to have a configuration for both laptop and desktop
    ## laptop also needs HDMI added for ultrawide res
    ### should use source as i am in hyprland then add "more" per-device-wallpaper.conf for each machine
    #### messy-ish but a simple workaround
  };
}
