{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      credential.helper = "libsecret";    # OR "store"  # What is the most secure option?
      core.askPass = "";                  # "" = use terminal to ask pass
      github.user = "psiri";
      init.defaultBranch = "main";
    };
    lfs = {
      enable = false;
    };
    # signing = {
    #   key = "";                           # FIXME - Update signing key
    #   signByDefault = true;
    # };
    userEmail = "paulsiri1@gmail.com";
    userName = "Paul Siri";
  };

  # programs.git = {
  #   enable = true;
  #   # config = {
  #   #   init =  {
  #   #     defaultBranch = "main";
  #   #   };
  #   #   url = {
  #   #     "https://github.com/" = {
  #   #       insteadOf = [
  #   #         "gh:"
  #   #         "github:"
  #   #       ];
  #   #     };
  #   #   };
  #   # };
  #   lfs.enable = false;
  # };
}
