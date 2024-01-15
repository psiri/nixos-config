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
    allowed_extensions = [
      #"cfhdojbkjhnklbpkdaibdccddilifddb" # Adblock Plus
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      #"inomeogfingihgjfjlpeplalcfajhgai" # Chrome Remote Desktop
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "ponfpcnoihfmfllpaingbgckeeldkhle" # Enhancer for YouTube
      #"callobklhcbilhphinckomhgkigmfocg" # Google Endpoint Verification
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
    ];
  in

{
  home-manager.users.${user}.home.file.".config/hypr/per-app/${chrome_version}.conf" = {
    text = ''
      bind = $mainMod, W, exec, ${chrome_version}
    '';
  };

  environment.sessionVariables = rec {MOZ_ENABLE_WAYLAND = "1";};

  users.users.${user}.packages = with pkgs; [pkgs."${chrome_version}"];
  programs."${chrome_version}" = {
    enable = true;
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL= "https://encrypted.google.com/search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:searchClient}{google:sourceId}{google:instantExtendedEnabledParameter}ie={inputEncoding}";
    extensions = ${allowed_extensions};
    extraOpts = {
      "BrowserSignin" = 1;
      "CalendarIntegrationEnabled" = true;
      "CloudReportingEnabled" = false; # Enable or disable Chrome reporting to Google Admin console
      "DefautCookiesSetting" = 4;      # 1= Allow all sites to set local data (default), 2= Do not allow, 4= Keep for the duration of session
      "DefaultGeolocationSetting" = 3; # 1=Allow sites to track, 2=Do not allow, 3=Ask whenever a site wants to track
      "DeviceAutoUpdateP2PEnabled" = false; # Whether P2P is allowed for OS update payloads
      "DeviceUpdateHttpDownloadsEnabled" = false; # true = allow HTTP, false = force HTTPS
      "DriveDisabled" = false; # Whether or not to disable Drive in ChromeOS files app
      "DriveDisabledOverCellular" = true; # Whether or not to disable Drive in ChromeOS files app when on cellular connections
      "DriveFileSncAvailable" = "visible";     # visable = user can use file sync feature, disabled = disabled
      "SystemTimezone" = "America/Los_Angeles";
      "SystemUse24HourClock" = false;
      ###########################################
      #               EXTENSIONS                #
      ###########################################
      "BlockExternalExtensions" = false; # Whether or not external extensions are allowed
      "ExtensionAllowedTypes" = [ "extension", "theme" ] # extension, theme, user_script, hosted_app, legacy_packaged_app, platform_app
      "ExtensionInstallAllowlist" = ${allowed_extensions};
      "ExtensionBlocklist" = [ "*" ];                    # * = all extensions blocked unless they are explicitly on the ExtensionInstallAllowlist
      "ExtensionInstallForceList" = [];
      "ExtensionInstallTypeBlocklist" = [];              # Which extension types are blocked
      #"ExtensionSettings" = {}; #TODO
      "ExtensionUnpublishedAvailability" = 1;            # 0=Allow, 1=Disable unpublished extensions
      ###########################################
      #           HTTP AUTHENTICATION           #
      ###########################################
      #"AllHttpAuthSchemesAllowedForOrigins" = [];         # Which origins allow all HTTP authentication schemes
      ###########################################
      #          IDLE BROWSER ACTIONS           #
      ###########################################
      "IdleTimeout" = 30;        # Length of time without user input before the browser runs "IdleTimeoutActions"
      "IdleTimeoutActions" = [
        # close_browsers
        # show_profile_picker
        clear_browsing_history
        clear_download_history
        clear_cookies_and_other_site_data
        clear_cached_images_and_files
        clear_password_signin
        clear_autofill
        # clear_site_settings
        clear_hosted_app_data
        # reload_pages
      ];
      ###########################################
      #                 KERBEROS                #
      ###########################################
      "KerberosAccounts" = [];
      "KerberosAddAccountsAllowed" = false;  # true = Allow users to add Kerberos accoutns
      "KerberosEnabled" = false;             # true = Enable Kerberos, false = disable
      "KerberosRememberPasswordEnabled" = false; # true = Allow users to remember Kerberos passwords
      ###########################################
      #             LINUX CONTAINER             #
      ###########################################
      "CrostiniAllowed" = false;  # (ChromeOS) Allow users to use virtual machines needed to support Linux apps
      #"CrostiniAnsiblePlaybook" = {}; # (ChromeOS) Ansible playbook that should be executed in the default Crostini container
      "CrostiniPortForwardingAllowed" = false; # (ChromeOS) whether port forwarding into the Linux VM is allowed
      "DeviceUnaffiliatedCrostiniAllowed" = false; # (ChromeOS) whether or not to allow unaffiliated users to use VMs
      "SystemTerminalSshAllowed" = false; # ChromeOS) whether or not SSH Termina System App is enabled
      "VirtualMachinesAllowed" = false;   # ChromeOS) whether or not VMs are allowed
      ###########################################
      #                   MISC                  #
      ###########################################
      "AbusiveExperienceInterventionEnforce" = true; # If SafeBrowsing is enable, true= prevent sites with abusive experiences from opening new windows or tabs
      "AdsSettingForIntrusiceAdsSites" = 2; # 1 = Allow ads on all sites, 2= Do not allow ads on sites with intrusive ads
      "AdvancedProtectionAllowed" = true;  # Whether or not users enrolled in the Advanced Protection program will receive extra protections
      "AllowDeletingBrowserHistory" = true;
      "AllowScreenLoack" = true;
      #"AllowSystemNotifications" = false;  # Whether Chrome is allowed to use system notifications
      #"AllowWebAuthnWithBrokenTlsCerts" = false; # true = Allow WebAuthn API requests on sites with broken TLS certs
      "AlwaysOpenPdfExternally" = null; # true = Always open with external viewer, false=always open with internal, not set = allow user to decide
      "AudioCaptureAllowed" = true;     # true = Enable audio input
      #"AudioCaptureAllowedUrls" = [];     # true = Specific URLs/patterns granting access to audio capture devices without prompt
      "AudioOutputAllowed" = true;      # true = enable audio output
      "AudioSandboxEnabled" = null;     # true = Always sandbox the process, false = never, not set = use default
      "BlockThirdPartyCookies" = true;  # true = Block 3rd party cookies
      "BrowserAddPersonEnabled" = true; # true = Allows adding a person to the user manager
      "BrowserLabsEnabled" = false;     # true = Users can access browser experimental features
      "BrowserSignIn" = 1;              # 0 = Disable, 1=Enable, 2=Force sign-in
      "ClearBrowsingDataOnExitList" = [ # List of all browsing data types that should be deleted when
        browsing_history                # the user closes all browser windows
        download_history
        cookies_and_other_site_data
        cached_images_and_files
        password_signin
        autofill
        site_settings
        hosted_app_data
      ];
      "CommandLineFlagSecurityWarningsEnabled" = true; # true = show securitry warnings when potentially dangerous command-line flags are used
      "DefaultBwoeserSettingEnabled" = false;          # true = Enable default browser check on startup
      #"DefaultDownloadDirectory"     = "$HOME/Downloads" # unset = use platform-specific defaults
      "DnsOverHttpsMode" = "automatic"  # off = disable DoH, automatic = Enable with insecure fallback, secure = force DoH only
      #DnsOverHttpsTemplates = 
      "DownloadRestrictions" = 4; # 0 = off/no restrictions, 1= blocks malicious files AND dangerous file types, 2= 1 + uncommon/unwanted file types, 3 = blocks all downloads, 4=blocks malicious files but not file types
      # "EnableOnlineRevocationChecks" = true; # true = enable OCSP/CRL checks
      "EncryptedClientHelloEnabled" = true; # true = enable ECH to encrypt sensitive fields in ClientHello
      "ExplicitlyAllowedNetworkPorts" = []; # List of ports for which outgoing connections will be allowed on. Leaving empty or unset = blocks all restricted ports
      "FeedbackSurveysEnabled" = false;
      "ForceEphemeralProfiles" = false; # true = Clear profile data on disk when a user session ends
      "ForceGoogleSafeSearch" = false;
      "ForceYouTubeRestrict" = 0; # 0 = Do not enforce, 1 = Enforce moderate or better, 2 = Enforce strict
      "HttpsOnlyMode" = "allowed"; # allowed = allow users to enable, disallowed = do not allow, force_enabled = force enabled
      "HttpsUpgradesEnabled" = true; # true / unset = HTTP-to-HTTPS upgrades may be applied (if able), false = disable
      "ImportAutoFillFormData" = false;
      "ImportBookmarks" = false;
      "ImportHistory" = false;
      "ImportHomepage" = false;
      "ImportSavedPasswords" = false; # true = enable import of saved passwords on first run
      "ImportSearchEngine" = false;
      "IncognitoModeAvailability" = 0; # 0 = Available, 1 = Disabled, 2 = Forced (on)
      "InsecureFormsWarningsEnabled" = true; # true = show warnings and disable autofill on insecure forms
      "InsecureHashesInTLSHandshakesEnabled" = false; # false = disabled legacy/insecure hashes during the TLS handshake process, not set = use default values
      "MetricsReportingEnabled" = false; # true = enable reporting of usage and crash data, false = disable
      #"NetworkServiceSandboxEnabled" = true;
      "PostQuantumKeyAgreementEnabled" = true;
      "QuicAllowed" = true;
      "RemoteDebuggingAllowed" = false;
      "SSLErrorOverrideAllowed" = true;
      #"SSLErrorOverrideAllowedForOrigins" = [];
      "SafeSitesFilterBehavior" = 0; # 0 = Do not filter sites for adult content, 1 = filter TLDs
      #"SavingBrowserHistoryDisabled" = false; # true = Disable saving browser history
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = ["en-US"];
      "SyncDisabled" = false; # Whether to disable Google Chrome Sync
      "SyncTypesListDisabled" = ["passwords"]; # Exclude the specified data types from sync
      ###########################################
      #            PASSWORD MANAGER             #
      ###########################################
      "PasswordDismissCompromisedAlertEnabled" = false; # true = enable dismissing compromised password alerts
      "PasswordLeakDetectionEnabled" = true; # true = check wheter usernames/passwords were part of a leak
      "PasswordManagerEnabled" = false;
      "PasswordSharingEnabled" = false;
      ###########################################
      #                 PRINTING                #
      ###########################################
      "PrintingEnabled" = true;
      ###########################################
      #             PRIVACY SANDBOX             #
      ###########################################
      "PrivacySandboxAdMeasurementEnabled" = true;
      "PrivacySandboxAdTopicsEnabled" = true; # true = allow users to turn on or off the Privacy Sandbox Ad topics
      "PrivacySandboxPromptEnabled" = false;
      "PrivacySandboxSiteEnabledAdsEnabled" = true;
      ###########################################
      #     PRIVATE NETWORK REQUEST SETTINGS    #
      ###########################################
      "InsecurePrivateNetworkRequestsAllowed" = false; # true = Allow websites to make requests to any network endpoint in an insecure mannger. false = Use default behavior
      #"InsecurePrivateNetworkRequestsAllowedForUrls" = [];
      #"PrivateNetworkAccessRestrictionsEnabled" = null;
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
