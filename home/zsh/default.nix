{
  config,
  inputs,
  outputs,
  pkgs,
  nix-colors,
  user,
  ...
}: {

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "line"];
    syntaxHighlighting.patterns = {};
    syntaxHighlighting.styles = {"globbing" = "none";};
    #promptInit = "info='n host cpu os wm sh n' fet.sh";
    # ohMyZsh = {
    #   enable = true;
    #   plugins = ["sudo" "terraform" "systemadmin" "vi-mode" "colorize" "powerlevel10k"];
    #   theme = "powerlevel10k"; # robbyrussel jnrowe muse obraun ys
    # };
  };

  home-manager.users.${user}.programs.zsh = {
    enable = true;
    enableAutosuggestions  = false;
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
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "line"];
    # syntaxHighlighting.patterns = {};
    syntaxHighlighting.styles = {"globbing" = "none";};
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = ["sudo" "terraform" "systemadmin" "vi-mode" "colorize" "powerlevel10k"];
    #   theme = "powerlevel10k"; # robbyrussel jnrowe muse obraun ys
    # };
  };
}