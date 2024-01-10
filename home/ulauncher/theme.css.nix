# please see README.md
# original theme by SirHades696 with nix-colors added by kye / kel / dai
{
  user,
  inputs,
  config,
  ...
}: {
  # taken from:
  # https://github.com/chriskempson/base16/blob/main/styling.md
  #
  #  base00 - Default Background
  #  base01 - Lighter Background (Used for status bars, line number and folding marks)
  #  base02 - Selection Background
  #  base03 - Comments, Invisibles, Line Highlighting
  #  base04 - Dark Foreground (Used for status bars)
  #  base05 - Default Foreground, Caret, Delimiters, Operators
  #  base06 - Light Foreground (Not often used)
  #  base07 - Light Background (Not often used)
  #  base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  #  base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
  #  base0A - Classes, Markup Bold, Search Text Background
  #  base0B - Strings, Inherited Class, Markup Code, Diff Inserted
  #  base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
  #  base0D - Functions, Methods, Attribute IDs, Headings
  #  base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
  #  base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  #
  ## notes:
  ### base0a is normally orange (other themes) its blue and the main highlight i use in toyyo-night-dark theme
  ### need to work on themes overall to get a more generalised theme applied
  ### that would look better across multiple base-16 themes

  home-manager.users.${user}.home.file.".config/ulauncher/user-themes/TokyoNight/theme.css" = {
    text = ''
      @define-color bg_color #${config.colorscheme.colors.base00};
      @define-color window_bg @bg_color;
      @define-color window_border_color #${config.colorscheme.colors.base0A};
      @define-color prefs_backgroud #${config.colorscheme.colors.base0E};

      /**
       * Input
       */
      @define-color selected_bg_color #${config.colorscheme.colors.base02};
      @define-color selected_fg_color #${config.colorscheme.colors.base06};
      @define-color input_color #${config.colorscheme.colors.base0E};
      @define-color caret_color darker(@input_color);

      /**
       * Result items
       */
      @define-color item_name #${config.colorscheme.colors.base08};
      @define-color item_text @selected_fg_color;

      @define-color item_box_selected #${config.colorscheme.colors.base03};
      @define-color item_text_selected #${config.colorscheme.colors.base0B};
      @define-color item_name_selected #${config.colorscheme.colors.base0D};

      @define-color item_shortcut_color #${config.colorscheme.colors.base0B};
      @define-color item_shortcut_shadow darker(@bg_color);
      @define-color item_shortcut_color_sel #${config.colorscheme.colors.base0F};
      @define-color item_shortcut_shadow_sel darker(@item_box_selected);

      .app {
          background-color: @window_bg;
          border: 5px solid @window_border_color;
          border-radius: 10px;
          margin: 0 -20px;
      }

      .input {
          color: @input_color;
          padding: 0px;
          margin-left: 15px;
          border-bottom: 1px solid alpha(@window_border_color,0.3);
      }

      /**
       * Selected text in input
       */
      .input *:selected,
      .input *:focus,
      *:selected:focus {
          background-color: alpha (@selected_bg_color, 0.9);
          color: @selected_fg_color;
      }

      .item-text {
          color: @item_text;
      }
      .item-name {
          color: @item_name;
      }

      .item-box {
          border-bottom: 1px dashed alpha(@window_border_color, 0.1);
      }

      .selected.item-box {
          background-color: @item_box_selected;
          border-radius: 15px;
      }

      .selected.item-box .item-text {
          color: @item_text_selected;
      }

      .selected.item-box .item-name {
          color: @item_name_selected;
      }

      .item-shortcut {
          color: @item_shortcut_color;
          text-shadow: 1px 1px 1px @item_shortcut_shadow;
      }
      .selected.item-box .item-shortcut {
          color: @item_shortcut_color_sel;
          text-shadow: 1px 1px 1px @item_shortcut_shadow_sel;
      }

      .result-box {
          margin: 0px 19px 0px 19px;
      }

      .prefs-btn {
          opacity: 0.8;
      }
      .prefs-btn:hover {
          background-color: @prefs_backgroud;
      }

      .no-window-shadow {
          margin: -20px;
      }
    '';
  };
}
