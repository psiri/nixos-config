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
    chrome_version = "chromium"; # FIXME - Change to your desired Chrome version, either "google-chrome" or "chromium"
  in

{
  home-manager.users.${user}.home.file.".config/hypr/per-app/${chrome_version}.conf" = {
    text = ''
      bind = $mainMod, W, exec, ${chrome_version}
    '';
  };

  environment.sessionVariables = rec {MOZ_ENABLE_WAYLAND = "1";};

  users.users.${user}.packages = with pkgs; ["${chrome_version}"];
  programs."${chrome_version}" = {
    enable = true;
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL= "https://encrypted.google.com/search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:searchClient}{google:sourceId}{google:instantExtendedEnabledParameter}ie={inputEncoding}";
    extensions = [
        #"cfhdojbkjhnklbpkdaibdccddilifddb" # Adblock Plus
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        #"inomeogfingihgjfjlpeplalcfajhgai" # Chrome Remote Desktop
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "ponfpcnoihfmfllpaingbgckeeldkhle" # Enhancer for YouTube
        #"callobklhcbilhphinckomhgkigmfocg" # Google Endpoint Verification
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      ];
    extraOpts = {
      "BrowserSignin" = 1;
      "SyncDisabled" = false;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = ["en-US"];
    };
    homepageLocation = "https://nixos.org/manual/nixos/stable/options";
  };
    
    # policies = {
    #   CaptivePortal = false;
    #   #DisabledCiphers = {};
    #   DisableFirefoxAccounts = false;
    #   DisableFirefoxStudies = true;
    #   DisablePasswordReveal = true;
    #   DisablePocket = true;
    #   DisableTelemetry = true;
    #   DisplayBookmarksToolbar = "always";
    #   DontCheckDefaultBrowser = true;
    #   #DownloadDirectory = "" # Set and lock download dir
    #   EnableTrackingProtection = {
    #     Value = true;
    #     Locked = true;
    #     Cryptomining = true;
    #     Fingerprinting = true;
    #     #Exceptions = [];
    #   };
    #   FirefoxHome = {
    #     Search = true;
    #     Pocket = false;
    #     Snippets = false;
    #     TopSites = false;
    #     Highlights = false;
    #   };
    #   NoDefaultBookmarks = true;
    #   OfferToSaveLogins = false;
    #   OfferToSaveLoginsDefault = false;
    #   PasswordManagerEnabled = false;
    #   Preferences = { 
    #     #"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
    #     "extensions.pocket.enabled" = lock-false;
    #     #"extensions.screenshots.disabled" = lock-true;
    #     "browser.topsites.contile.enabled" = lock-false;
    #     #"browser.formfill.enable" = lock-false;
    #     "browser.search.suggest.enabled" = lock-false;
    #     "browser.search.suggest.enabled.private" = lock-false;
    #     "browser.urlbar.suggest.searches" = lock-false;
    #     "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
    #     "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
    #     "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
    #     "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
    #     "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
    #     "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
    #     "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
    #     "browser.newtabpage.activity-stream.showSponsored" = lock-false;
    #     "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
    #     "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
    #   };
}
