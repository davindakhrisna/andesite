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
      # shells
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
      socat        # UNIX socket listener for Hyprland events

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

      # Themes, Icons & Cursors
      bibata-cursors
      papirus-icon-theme
      adw-gtk3
      gsettings-desktop-schemas
    ];

    # Wallust & Rofi Config Symlinks
    xdg.configFile."wallust".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/wallust";
    xdg.configFile."rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/rofi";

    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
    };

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        WantedBy = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    systemd.user.services.system-notifier = {
      Unit = {
        Description = "Desktop System Event Notifier (Network, Bluetooth, Battery)";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/hyprland/scripts/system-notifier.sh";
        Restart = "always";
        RestartSec = 3;
      };
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

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        shell = "zsh";
        font_family = "Iosevka Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = "12.0";
        window_padding_width = 12;
        background_opacity = "0.85";
        confirm_os_window_close = 0;
        enable_audio_bell = false;
      };
      extraConfig = ''
        include ${config.home.homeDirectory}/.cache/wallust/colors-kitty.conf
      '';
    };
  };
}
