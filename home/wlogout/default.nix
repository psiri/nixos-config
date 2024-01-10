{
  pkgs,
  user,
  config,
  ...
}: {
  imports = [
    ./style.css.nix
    ./layout.nix
  ];

  home-manager.users.${user} = {
    programs.wlogout = {
      enable = true;
    };
    home.file.".config/hypr/per-app/wlogout.conf" = {
      text = ''
        bind = $mainMod, L, exec, wlogout -p layer-shell
        windowrulev2 = animation snappy, float, fullscreen, class:^(wlogout)$
      '';
    };
  };
}
