{
  pkgs,
  user,
  ...
}: {
  # TODO add nix-colors to bottom.toml.nix
  imports = [./bottom.toml.nix];

  users.users.${user}.packages = with pkgs; [bottom];

  home-manager.users.${user} = {
    home.file.".config/hypr/per-app/bottom.conf" = {
      text = ''
        # bottom uses per-app in foot / kitty / fish / zsh congfig currently
      '';
    };
  };
}
