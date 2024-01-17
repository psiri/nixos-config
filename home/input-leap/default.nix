{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  
  users.users.${user}.packages = with pkgs; [
    ${nixpkgs-unstable}.input-leap
  ];
}
