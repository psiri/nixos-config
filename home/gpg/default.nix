{
  config,
  pkgs,
  user,
  ...
}: {

  #services.pcscd.enable = true;

  # services.gpg-agent = {
  #   enable = true;
  #   pinentryFlavor = "gnome3";
  # };

  # home-manager.users.${user}.programs.gpg = {
  #   enable = true;
  #   mutableKeys = true;
  #   mutableTrust = true;
  #   #publicKeys = "";
  # };
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
