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
    font = "ter-v32n";
    #keyMap = "us";
  };
}