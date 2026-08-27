{ self, ... }: {
  flake.homeModules.desktop-base = {
    lib,
    pkgs,
    inputs,
    config,
    ...
  }: {
    imports = lib.optional (inputs ? helium) inputs.helium.homeModules.default;

    home.packages = with pkgs;
    [
      # terminal & shells
      foot
      kitty
      btop
      yazi

      # password manager & launchers
      rofi
      rbw
      rofi-rbw-wayland
      wtype
      pinentry-gnome3

      # file manager
      thunar

      # Audio & Bluetooth
      wiremix      # PipeWire TUI audio mixer
      bluetui      # Bluetooth TUI manager
      pamixer      # PulseAudio/PipeWire volume control CLI
      pulseaudio   # Provides pactl CLI tool
      
      # Network & WiFi
      gazelle-tui  # NetworkManager WiFi TUI

      # Display & Monitor Management
      hyprmon      # Hyprland Monitor layout & settings TUI
      wlr-randr    # Wayland xrandr equivalent (query & set displays)
      hyprsunset   # Blue-light filter & color temperature utility

      # Toolkit Screenshot
      grim         # Wayland screenshot tool
      slurp        # Screen region selector
      satty        # Modern screenshot editor & annotation tool
      swappy       # Lightweight image editor
      wl-screenrec # Hardware-accelerated screen recorder

      # System, Clipboard & Utilities
      cliphist
      rofimoji
      polkit_gnome
      zathura
      cava
    ];

    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
    };

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
