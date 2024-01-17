{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  
  environment.systemPackages = with pkgs; [
    nixos-unstable.input-leap
  ];
}
