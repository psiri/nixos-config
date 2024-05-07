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
      github.user = "psiri";              # FIXME - Change to your Git username
      init.defaultBranch = "main";
    };
    lfs = {
      enable = false;
    };
    signing = {
      key = "F8B7F272F4FA425071E401E4B5BC49AAA49DB77A";  # FIXME - Change to your signing key
      signByDefault = false;
    };
    userEmail = "paulsiri1@gmail.com";                   # FIXME - Change to your email
    userName = "Paul Siri";                              # FIXME - Change to your name
  };
}
