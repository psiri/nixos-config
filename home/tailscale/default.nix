{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
