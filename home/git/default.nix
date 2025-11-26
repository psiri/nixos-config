{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.git = {
    enable = true;
    settings = {
      color.ui = true;
      #credential.helper = "libsecret";   # OR "store"  # What is the most secure option?
      core.askPass = "";                  # "" = use terminal to ask pass
      github.user = "psiri";              # FIXME - Change to your Git username
      init.defaultBranch = "main";
      user.email = "paulsiri1@gmail.com"; # FIXME - Change to your email
      user.name  = "Paul Siri";           # FIXME - Change to your name
    };
    lfs = {
      enable = false;
    };
    signing = {
      key = "B5BC49AAA49DB77A"; #"F8B7F272F4FA425071E401E4B5BC49AAA49DB77A";  # FIXME - Change to your signing key
      signByDefault = true;
    };
  };

  #####################################################
  # USER-SPECIFIC .gitconfig POPULATED BY SOPS SECRET #
  #####################################################

  sops.templates."personal-gitconfig".path = "/home/psiri/.gitconfig";
  sops.templates."personal-gitconfig".owner = "psiri";
  sops.templates."personal-gitconfig".mode = "0400"; # read by owner
  sops.templates."personal-gitconfig".content = ''
  ${config.sops.placeholder.psiri_gitconfig}
  '';
  # The tempalte above expects the entire .gitconfig to be pulled from a sops secret named "psiri_gitconfig"

}
