{
  config,
  pkgs,
  user,
  ...
}: 

# NOTE: BRAVE AUTOMATICALLY ASSUMES THE SETTINGS FROM CHROMIUM IF CHROMIUM IS CONFIGURED. 
# SEE ../chome/default.nix for Chromium configuration options

{
  home-manager.users.${user}.home.file.".config/hypr/per-app/brave.conf" = {
    text = ''
      bind = $mainMod, B, exec, brave
      windowrulev2 = opacity 1.0 1.0, class:^(brave-browser)$   # Disables opacity of Brave windows
      windowrulev2 = nodim, class:^(brave-browser)$             # Disables dimming of Brave windows
    '';
  };

  users.users.${user}.packages = with pkgs; [brave];
}
