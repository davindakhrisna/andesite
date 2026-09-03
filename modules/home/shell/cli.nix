{
  flake.homeModules.utils-cli = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Nix search & system info
      nix-search-tv
      fastfetch
      areofyl-fetch

      # Modern CLI replacements
      bat # cat
      duf # df
      eza # ls
      ripgrep # grep
      fd # find

      # Compatibility & execution
      appimage-run

      # Media CLI & control
      playerctl
      brightnessctl
      yt-dlp
      ffmpeg
      mpv

      # Clipboard & Notifications
      wl-clipboard
      libnotify
    ];

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    services.udiskie = {
      enable = true;
      notify = true;
      automount = true;
      tray = "never";
    };
  };
}
