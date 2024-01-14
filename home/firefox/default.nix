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
      CaptivePortal = false;
      DisableFirefoxAccounts = false;
      DisableFirefoxStudies = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
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
        "uBlock-origin" = {
          installation_mode = "force_installed";
          installation_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      SSLVersionMin = "tls1.2";
    };
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisablePasswordReveal = true;
        DisablePocket = true;
        DisableFirefoxAccounts = false;
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "always";
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          #Exceptions = [];
        };
        ExtensionSettings = {
          "*" = {
            blocked_install_message = "This extension has been blocked by your organization.";
            allowed_types = ["extension"];
          };
          "uBlock@raymondhill.net" = {
            installation_mode = "force_installed";
            installation_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
        };
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
        SSLVersionMin = "tls1.2";
      };
    };
    # policies # TODO - automatically install Firefox extensions
  };
}
