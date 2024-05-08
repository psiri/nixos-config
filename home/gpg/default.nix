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

  # NOTE: IF not working, run export GPG_TTY=$(tty)

  home-manager.users.${user}.home.file = {
  "/.gnupg/gpg.conf" = {
      text = ''
use-agent
#pinentry-mode loopback
      '';
    };
"/.gnupg/gpg-agent.conf" = {
    text = ''
pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses
    '';
  };
  };
}
