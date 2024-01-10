{user, ...}: {
  home-manager.users.${user}.home.file.".config/ulauncher/user-themes/TokyoNight/theme-gtk-3.20.css" = {
    text = ''

      @import url("theme.css");

      .input {
          caret-color: @caret_color;
      }

      .selected.item-box {
          /* workaround for a bug in GTK+ < 3.20 */
          border: none;
      }
    '';
  };
}
