{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    #publicKeys = "";
  };
}
