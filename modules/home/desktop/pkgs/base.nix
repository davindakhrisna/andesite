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

    # Rofi, Yazi & GTK Config Symlinks
    xdg.configFile."rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/rofi";
    xdg.configFile."yazi/theme.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/yazi/theme.toml";
    xdg.configFile."gtk-3.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/gtk/gtk.css";
    xdg.configFile."gtk-4.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/gtk/gtk.css";

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

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        vim_keys = true;
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

        # OLED Monochrome Palette
        background = "#000000";
        foreground = "#f5f5f5";
        cursor = "#ffffff";
        cursor_text_color = "#000000";
        selection_background = "#ffffff";
        selection_foreground = "#000000";

        # 16 ANSI Palette (Monochrome with functional accents)
        color0 = "#1a1a1a";
        color1 = "#ef4444";
        color2 = "#22c55e";
        color3 = "#eab308";
        color4 = "#ffffff";
        color5 = "#d4d4d4";
        color6 = "#a3a3a3";
        color7 = "#f5f5f5";

        color8 = "#525252";
        color9 = "#f87171";
        color10 = "#4ade80";
        color11 = "#facc15";
        color12 = "#ffffff";
        color13 = "#e5e5e5";
        color14 = "#d4d4d4";
        color15 = "#ffffff";
      };
    };
  };
}
