{
  config,
  pkgs,
  user,
  ...
}: 


{
  home-manager.users.${user}.home.file.".config/hypr/per-app/brave.conf" = {
    text = ''
      bind = $mainMod, B, exec, brave
      windowrulev2 = opacity 1.0 1.0, class:^(brave)$   # Disables opacity of Brave windows
      windowrulev2 = nodim, class:^(brave)$             # Disables dimming of Brave windows
    '';
  };

  users.users.${user}.packages = with pkgs; [brave];
}
