{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  home-manager.users.${user} = {
    programs.joplin-desktop = {
      enable = true;
      sync.interval = "10m";
      sync.target = "s3";
    };
  };


#   home-manager.users.${user}.home.file = {
#   "/.gnupg/gpg.conf" = {
#       text = ''
# use-agent
#       '';
#     };
# "/.gnupg/gpg-agent.conf" = {
#     text = ''
# pinentry-program ${pkgs.pinentry-tty}/bin/pinentry
# default-cache-ttl 460000
# allow-preset-passphrase
#     '';
#   };
#   };
}
