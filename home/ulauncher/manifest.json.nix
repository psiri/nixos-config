{
  config,
  user,
  ...
  # modified from 00 and 01 to 06 and 07
}: {
  home-manager.users.${user}.home.file.".config/ulauncher/user-themes/TokyoNight/manifest.json" = {
    text = ''
      {
        "manifest_version": "1",
        "name": "TokyoNight-Theme",
        "display_name": "TokyoNight Theme",
        "extend_theme": "dark",
        "css_file": "theme.css",
        "css_file_gtk_3.20+": "theme-gtk-3.20.css",
        "matched_text_hl_colors": {
        "when_selected": "#${config.colorscheme.colors.base06}",
        "when_not_selected": "#${config.colorscheme.colors.base07}"
        }
      }
    '';
  };
}
