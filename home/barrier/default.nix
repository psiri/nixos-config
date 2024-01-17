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
      enableCrypro = true;
      enableDragDrop = false;
      extraFlags = [ "-f" ];
      name = "${config.networking.hostName}";
      #server = "your-servername-here:24800"
    };
  };
}
