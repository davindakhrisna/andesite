{
  flake.homeModules.desktop-helium = {
    inputs,
    lib,
    ...
  }: {
    imports = lib.optional (inputs ? helium) inputs.helium.homeModules.default;

    programs.helium = {
      enable = true;

      policies = {
        BrowserSignin = 0;
        SyncDisabled = true;
        SigninAllowed = false;

        PasswordManagerEnabled = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        SafeBrowsingEnabled = false;
        MetricsReportingEnabled = false;
        SpellCheckServiceEnabled = false;
        DefaultCookiesSetting = 1;
        DefaultGeolocationSetting = 2;
        DefaultNotificationsSetting = 2;
        DefaultPopupsSetting = 2;

        DefaultBrowserSettingEnabled = false;
        DeveloperToolsAvailability = 1;

        DnsOverHttpsMode = "automatic";
        DnsOverHttpsTemplates = "https://dns.quad9.net/dns-query";

        DefaultSearchProviderEnabled = true;
        DefaultSearchProviderName = "Startpage";
        DefaultSearchProviderSearchURL = "https://www.startpage.com/do/search?q={searchTerms}";
        DefaultSearchProviderSuggestURL = "https://www.startpage.com/do/suggest?q={searchTerms}";

        BookmarkBarEnabled = false;

        ExtensionInstallForcelist = [
          "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        ];
      };
    };
  };
}
