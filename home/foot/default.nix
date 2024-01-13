{
  config,
  inputs,
  outputs,
  pkgs,
  nix-colors, # TODO theming
  user,
  ...
}: {
  users.users.${user}.packages = with pkgs; [foot];

  home-manager.users.${user}.home.file.".config/hypr/per-app/foot.conf" = {
    text = ''
      windowrulev2 = opacity 0.8 0.8, class:^(foot)$
      windowrulev2 = size 700 300, class:^(foot)$
      bind = $mainMod, Q, exec, foot
      bind = control, escape, exec, foot -e btm
      windowrulev2 = tile, class:^(foot)$
    '';
  };
}
