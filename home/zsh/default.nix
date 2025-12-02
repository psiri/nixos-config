{
  config,
  inputs,
  outputs,
  pkgs,
  nix-colors,
  user,
  ...
}: {
  # ZSH with powerlevel10k plugin

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    interactiveShellInit = ''
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey '^[[B' history-substring-search-down
    '';
    # Automatically start Hyprland after TTY login. 
    # Note: `exec Hyprland` is used to return user to login prompt if/when Hyprland exits.
    shellInit = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ];then exec Hyprland;fi
    '';
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "line"];
    syntaxHighlighting.patterns = {};
    syntaxHighlighting.styles = {"globbing" = "none";};
    #promptInit = "info='n host cpu os wm sh n' fet.sh";
    # ohMyZsh = {
    #   enable = true;
    #   plugins = ["sudo" "terraform" "systemadmin" "vi-mode" "colorize"]; # git ansible aws argocd docker gh github gitignore history kubectl nmap python terraform virtualenv vscode
    #   theme = "ys"; # robbyrussel jnrowe muse obraun ys
    # };
  };

  home-manager.users.${user}.programs.zsh = {
    enable = true;
    autosuggestion.enable  = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    initContent = ''
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey '^[[B' history-substring-search-down

      # If Kitty passed a specific history file, switch to it now
      if [[ -n "$KITTY_TAB_HISTORY" ]]; then
        # Ensure the custom history file exists
        if [[ ! -f "$KITTY_TAB_HISTORY" ]]; then
          touch "$KITTY_TAB_HISTORY"
        fi
        
        # 'fc -p' switches history to the new file and clears the previous (global) history from memory.
        # Usage: fc -p [file] [histsize] [savehist]
        fc -p "$KITTY_TAB_HISTORY" 50000 50000
        
        # Ensure commands are written immediately, not just on exit
        setopt INC_APPEND_HISTORY
        setopt SHARE_HISTORY
      fi
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
    # Automatically start Hyprland after TTY login. 
    # Note: `exec Hyprland` is used to return user to login prompt if/when Hyprland exits.
    loginExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ];then exec Hyprland;fi
    '';
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "line"];
    # syntaxHighlighting.patterns = {};
    syntaxHighlighting.styles = {"globbing" = "none";};
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = ["sudo" "terraform" "systemadmin" "vi-mode" "colorize"]; # git ansible aws argocd docker gh github gitignore history kubectl nmap python terraform virtualenv vscode
    #   theme = "ys"; # robbyrussel jnrowe muse obraun ys
    # };
  };
}