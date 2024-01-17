{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  services.rkvm = {
    enable = true;
    client = {
      enable = true;
      #settings = {};
      settings.certificate = "/home/${user}/.config/rkvm/rkvm-certificate";
      settings.server = "10.0.100.50:5258";
      settings.password = "123456789101112131415161718192021";
    };
    server = {
      enable = false;
      #settings = {};
      settings.certificate = "/home/${user}/.config/rkvm/rkvm-certificate.pem";
      settings.key = "~/.config/rkvm/rkvm-key.pem";
      settings.listen = "0.0.0.0:5258";
      settings.password = "123456789101112131415161718192021";
      settings.switch-keys = [
        "left-alt"
        "left-ctrl"
      ];
    };
  # home.file.".config/rkvm/per-app/kitty.conf" = {
  #   text = ''
  #     windowrulev2 = opacity 0.8 0.8, class:^(kitty)$
  #     windowrulev2 = size 700 300, class:^(kitty)$
  #     windowrulev2 = tile, class:^(kitty)$
  #     bind = $mainMod, Q, exec, kitty
  #     bind = control, escape, exec, kitty -e btm
  #     windowrule = tile, title:zsh
  #     windowrule=tile,^(kitty)$
  #     windowrule=tile,title:^(kitty)(.*)$
  #   '';
  # };
  };
}
