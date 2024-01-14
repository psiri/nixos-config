{
  config,
  pkgs,
  user,
  ...
}: 

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in

{
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
      #DisabledCiphers = {};
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
        "*" = {
          blocked_install_message = "This extension has been blocked by your organization.";
          installation_mode = "blocked"; # Blocks all extensions except those explicitly-defined below
        };
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then, download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
        # Bitwarden:
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger:
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      FirefoxHome = {
        Search = true;
        Pocket = false;
        Snippets = false;
        TopSites = false;
        Highlights = false;
      };
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      Preferences = { 
        #"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "extensions.pocket.enabled" = lock-false;
        #"extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        #"browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };
      SearchBar = "unified"; # Alternatives: "separate"
      SSLVersionMin = "tls1.2";
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
    # package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    #   extraPolicies = {
    #     CaptivePortal = false;
    #     DisablePasswordReveal = true;
    #     DisablePocket = true;
    #     DisableFirefoxAccounts = false;
    #     DisableFirefoxStudies = true;
    #     DisableTelemetry = true;
    #     DisplayBookmarksToolbar = "always";
    #     DontCheckDefaultBrowser = true;
    #     EnableTrackingProtection = {
    #       Value = true;
    #       Locked = true;
    #       Cryptomining = true;
    #       Fingerprinting = true;
    #       #Exceptions = [];
    #     };
    #     ExtensionSettings = {
    #       "*" = {
    #         blocked_install_message = "This extension has been blocked by your organization.";
    #         allowed_types = ["extension"];
    #       };
    #       "uBlock@raymondhill.net" = {
    #         installation_mode = "force_installed";
    #         installation_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    #       };
    #     };
    #     NoDefaultBookmarks = true;
    #     OfferToSaveLogins = false;
    #     OfferToSaveLoginsDefault = false;
    #     PasswordManagerEnabled = false;
    #     FirefoxHome = {
    #       Search = true;
    #       Pocket = false;
    #       Snippets = false;
    #       TopSites = false;
    #       Highlights = false;
    #     };
    #     UserMessaging = {
    #       ExtensionRecommendations = false;
    #       SkipOnboarding = true;
    #     };
    #     SSLVersionMin = "tls1.2";
    #   };
    # };
  };
}
