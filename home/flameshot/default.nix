{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  home-manager.users.${user}.services.flameshot = {
    enable = true;
    settings = {       # Example configuration.ini has be included here for reference. Also see (https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini)
      General = {
        savePath="/tmp"; # Save to /tmp (which is RAM with our config) to ensure screenshots are non-persistent
        saveAsFileExtension=".png";
        disabledTrayIcon=false;
        startupLaunch=true;
        saveAfterCopy=false;
        useJpgForClipboard=false;
        #jpegQuality=100; # 100 = maximum
      };
    };
  };
}