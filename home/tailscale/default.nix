{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  lib,
  ...
}: {
  # Create an auth key file containing the SOPS secret "tailscale_auth_key"
  sops.templates."tailscale_auth_key".owner = "root";
  sops.templates."tailscale_auth_key".mode = "0600";
  sops.templates."tailscale_auth_key".content = ''
  ${config.sops.placeholder.tailscale_auth_key}
    '';

  services.tailscale = {
    enable = true;
    disableTaildrop = false;
    interfaceName = "tailscale0";
    openFirewall = false;
    useRoutingFeatures = "client";
    # Use the path to the decrypted secret provided by sops-nix
    authKeyFile = ${config.sops.secrets.tailscale_auth_key.path};
    authKeyParameters.ephemeral = false;
    authKeyParameters.preauthorized = true;
  };
}
