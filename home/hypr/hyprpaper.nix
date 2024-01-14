{
  config,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/hypr/hyprpaper.conf" = {
    text = ''
      preload =  /home/${user}/Pictures/Wallpaper/1.jpg
      preload =  /home/${user}/Pictures/Wallpaper/2.jpg
      preload =  /home/${user}/Pictures/Wallpaper/3.jpg
      preload =  /home/${user}/Pictures/Wallpaper/4.jpg
      preload =  /home/${user}/Pictures/Wallpaper/5.jpg

      wallpaper = 0, /home/${user}/Pictures/Wallpaper/1.jpg
    '';
    # wallpaper = eDP-1, ~/nixos/wallpaper/5.jpg
    # this value needs to have a configuration for both laptop and desktop
    ## laptop also needs HDMI added for ultrawide res
    ### should use source as i am in hyprland then add "more" per-device-wallpaper.conf for each machine
    #### messy-ish but a simple workaround
  };
}
