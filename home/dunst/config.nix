{
  config,
  inputs,
  outputs,
  user,
  ...
}: {
  home-manager.users.${user}.home.file."/.config/dunst/dunstrc" = {
    text = ''
      [global]
      font="Hasklug Nerd Font Regular 9"
      frame_color="#${config.colorScheme.palette.base0A}"
      background="#${config.colorScheme.palette.base00}"
      foreground="#${config.colorScheme.palette.base05}"
      highlight="#${config.colorScheme.palette.base05}"
      progress_bar_corner_radius = 10
      height=300
      icon_theme=Qogir-dark
      enable_recursive_icon_lookup = true
      offset="30x50"
      origin="top-center"
      transparency=10
      width=300
      corner_radius=10
      frame_width=5
      timeout=4

      [urgency_normal]
      background="#${config.colorScheme.palette.base00}"
      foreground="#${config.colorScheme.palette.base05}"
      highlight="#${config.colorScheme.palette.base03}"
      timeout=4

      [urgency_critical]
      background="#${config.colorScheme.palette.base00}"
      foreground="#${config.colorScheme.palette.base0F}"
      frame_color="#${config.colorScheme.palette.base0F}"
      highlight="#${config.colorScheme.palette.base0A}"
      timeout=5


    '';
  };
}
