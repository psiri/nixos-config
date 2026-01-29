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
      windowrule = opacity 1.0 1.0, match:class ^(brave-browser)$   # Disables opacity of Brave windows
      windowrule = no_dim on, match:class ^(brave-browser)$             # Disables dimming of Brave windows
    '';
  };

  users.users.${user}.packages = with pkgs; [brave];
}
