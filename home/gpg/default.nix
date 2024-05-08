{
  config,
  pkgs,
  user,
  ...
}: {

  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry;
      #pkgs.pinentry-curses;
    };
  };

  # NOTE: IF not working, run export GPG_TTY=$(tty)
  # or 'echo "test" | gpg --clearsign' and enter your credentials to unlock

  home-manager.users.${user}.home.file = {
  "/.gnupg/gpg.conf" = {
      text = ''
#use-agent
pinentry-mode loopback
      '';
    };
"/.gnupg/gpg-agent.conf" = {
    text = ''
pinentry-program ${pkgs.pinentry-tty}/bin/pinentry
default-cache-ttl 460000
allow-preset-passphrase
    '';
  };
  };
}
# pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses