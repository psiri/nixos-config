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
        bind = $mainMod SHIFT, L, exec, wlogout -p layer-shell
        windowrule = animation snappy, float on, fullscreen on, match:class ^(wlogout)$
      '';
    };
  };
}
