{
  config,
  pkgs,
  user,
  ...
}: {

  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry; # Note: Tried specifying different packages, but this was the only method I could get the GPG password prompt to reliably appear under apps like VS Code
    };
  };

  # NOTE: IF not working, run export GPG_TTY=$(tty)
  # or 'echo "test" | gpg --clearsign' and enter your credentials to unlock

  home-manager.users.${user}.home.file = {
  "/.gnupg/gpg.conf" = {
      text = ''
use-agent
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
