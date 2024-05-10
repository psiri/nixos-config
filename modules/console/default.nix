{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # Default settings for the console
  console = {
    enable = true;
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-v16n";
    keyMap = "us";
    #useXkbConfig = true;
  };

  services.xserver.xkb.layout = "us";
  #services.xkbVariant = "us";
}