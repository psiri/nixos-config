{
  pkgs,
  user,
  ...
}: {

  # Client E
  users.users.${user}.packages = with pkgs; [
    gnumake
    yq
  ];
    # jq # already in system packages
}
