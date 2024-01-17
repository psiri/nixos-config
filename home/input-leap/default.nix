{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.input-leap
  ];
}
