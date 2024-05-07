# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{user, ...}: {
  home-manager.users.${user} = {
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    nix-colors,
    ...
  }: {
    # You can import other home-manager modules here
    imports = [
      # If you want to use modules your own flake exports (from modules/home-manager):
      # outputs.homeManagerModules.example

      # Or modules exported from other flakes (such as nix-colors):
      inputs.nix-colors.homeManagerModules.default

      # You can also split up your configuration and import pieces of it here:
      # inputs.ags.homeManagerModules.default # imports from root flake.nix then builds the package which is nice :)
    ];

    nixpkgs = {
      # You can add overlays here
      # overlays = [
      #   # Add overlays your own flake exports (from overlays and pkgs dir):
      #   outputs.overlays.additions
      #   outputs.overlays.modifications
      #   outputs.overlays.unstable-packages
      # ];
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
      };
    };

    # Add stuff for your user as you see fit:
    # programs.neovim.enable = true;
    # programs.hyprland.enable = true; # Enable Hyprland window manager
    # home.packages = with pkgs; [ steam ];

    # Enable home-manager and git
    programs.home-manager.enable = true;
    xdg.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    home.username = "${user}";
    home.homeDirectory = "/home/${user}";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "24.05";
  };
}