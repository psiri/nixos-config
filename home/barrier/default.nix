{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    services.barrier.client = {
      enable = true;
      enableCrypto = true;
      enableDragDrop = false;
      extraFlags = [ "-f" ];
      name = "${config.networking.hostName}";
      #server = "your-servername-here:24800"
    };
  };
}
