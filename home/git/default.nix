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
      credential.helper = "store";        # Looking for more secure option
      github.user = "psiri";
      init.defaultBranch = "main";
    };
    # signing = {
    #   key = "";                           # FIXME - Update signing key
    #   signByDefault = true;
    # };
    user.Email = "paulsiri1@gmail.com";
    user.Name = "Paul Siri";
  };

  programs.git = {
    enable = true;
    # config = {
    #   init =  {
    #     defaultBranch = "main";
    #   };
    #   url = {
    #     "https://github.com/" = {
    #       insteadOf = [
    #         "gh:"
    #         "github:"
    #       ];
    #     };
    #   };
    # };
    lfs.enable = false;
  };
}
