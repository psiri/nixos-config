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
      key = "3CA7C048A915F7F2E6DB3442515C6F9D35B95FC0";  # FIXME - Change to your signing key
      signByDefault = true;
    };
    userEmail = "paulsiri1@gmail.com";                   # FIXME - Change to your email
    userName = "Paul Siri";                              # FIXME - Change to your name
  };
}
