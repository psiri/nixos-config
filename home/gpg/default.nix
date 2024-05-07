{
  config,
  pkgs,
  user,
  ...
}: {

  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
