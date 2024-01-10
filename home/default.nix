{user, ...}: {
  home-manager.users.${user} = {
    pkgs,
    lib,
    config,
    inputs,
    outputs,
    nix-colors,
    ...
  }: {
    imports = [
      inputs.ags.homeManagerModules.default # imports from root flake.nix then builds the package which is nice :)
      inputs.nix-colors.homeManagerModules.default
    ];
    programs.home-manager.enable = true;
    xdg.enable = true;
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";
    home.stateVersion = "23.11";
  };
}
