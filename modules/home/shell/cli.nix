{
  flake.homeModules.utils-cli = {
    pkgs,
    ...
  }: let
    ns = pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    };
  in {
    home.packages = with pkgs; [
      # Nix search & info
      ns
      fastfetch
      areofyl-fetch
      fzf

      # Modern CLI replacements
      bat           # cat
      duf           # df
      eza           # ls
      ripgrep       # grep
      fd            # find

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
