{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "libsecret";
      user.name = "psiri";
      user.email = "paulsiri1@gmail.com";
    };
  };

  programs.git = {
    enable = true;
    config = {
      init =  {
        defaultBranch = "main";
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
    };
    lfs.enable = false;
  };
}
