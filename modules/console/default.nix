{
  config,
  inputs,
  outputs,
  pkgs,
  nix-colors,
  user,
  ...
}: {
  # Default settings for the console
  console = {
    enable = true;
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-v12n";
    keyMap = "us";
    #useXkbConfig = true;
  };

  services.xserver.layout = "us";
  #services.xkbVariant = "us";
}