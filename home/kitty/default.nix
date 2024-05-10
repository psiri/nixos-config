{
  config,
  inputs,
  outputs,
  pkgs,
  nix-colors,
  user,
  ...
}: {
  home-manager.users.${user} = {
    programs.kitty = {
      enable = true;
      settings = {
        active_tab_foreground = "#${config.colorScheme.colors.base05}";
        active_tab_background = "#${config.colorScheme.colors.base00}";

        foreground = "#${config.colorScheme.colors.base05}";
        background = "#${config.colorScheme.colors.base00}";
        url_color = "#${config.colorScheme.colors.base0E}";

        repaint_delay = "12";
        sync_to_monitor = "yes";
        background_opacity = "1.0";
        background_blur = "1";
        tab_bar_style = "powerline";
        tab_bar_edge = "top";
        tab_bar_margin_height = "3 3";
        tab_powerline_style = "angled";
        tab_activity_symbol = "@@";
        font_family = "Hack Nerd Font Mono";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = "10.0";
        cursor_shape = "beam";
        cursor_beam_thickness = "2.0";
        cursor_blink_interval = "0.5";
        strip_trailing_spaces = "always";
        extraCofig = ''
          symbol_map U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols
        '';
      };
    };
    home.file.".config/hypr/per-app/kitty.conf" = {
      text = ''
        windowrulev2 = opacity 0.8 0.8, class:^(kitty)$
        windowrulev2 = size 700 300, class:^(kitty)$
        windowrulev2 = tile, class:^(kitty)$
        bind = $mainMod, Q, exec, kitty
        bind = control, escape, exec, kitty -e btm
        windowrule = tile, title:zsh
        windowrule=tile,^(kitty)$
        windowrule=tile,title:^(kitty)(.*)$
      '';
    };
  };
}
