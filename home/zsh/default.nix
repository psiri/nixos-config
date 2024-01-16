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
    enableAutosuggestions  = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
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