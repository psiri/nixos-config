{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  lib,
  ...
}: {
  # sops.secrets.tailscale_auth_key = {
  #   #sopsFile = ./secrets.yaml; # Path to your encrypted secrets file
  #   key = "tailscale_auth_key"; # The key within your YAML file holding the auth key
  #   owner = "root";
  #   mode = "0400"; # Read-only for the owner
  # };

  #sops.templates."tailscale_auth_key".path = "/etc/tailscale/tskey-reusable";
  sops.templates."tailscale_auth_key".owner = "root";
  sops.templates."tailscale_auth_key".mode = "0600";
  sops.templates."tailscale_auth_key".content = ''
  ${config.sops.placeholder.tailscale_auth_key}
    '';

  services.tailscale = {
    enable = true;
    disableTaildrop = false;
    openFirewall = false;
    useRoutingFeatures = "client";
    # Use the path to the decrypted secret provided by sops-nix
    authKeyFile = ${config.sops.secrets.tailscale_auth_key.path};
    authKeyParameters.ephemeral = false;
    authKeyParameters.preauthorized = true;
  };
}
