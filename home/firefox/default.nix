{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/hypr/per-app/firefox.conf" = {
    text = ''
      bind = $mainMod, F, exec, firefox
    '';
  };

  environment.sessionVariables = rec {MOZ_ENABLE_WAYLAND = "1";};

  users.users.${user}.packages = with pkgs; [firefox];
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
    ];
    policies = {
      DisablePasswordReveal = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "always";
      DontCheckDefaultBrowser = true;
      #DownloadDirectory = "" # Set and lock download dir
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        #Exceptions = [];
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          installation_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      SSLVersionMin = "tls1.2"

    };
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };
    # policies # TODO - automatically install Firefox extensions
  };
}
