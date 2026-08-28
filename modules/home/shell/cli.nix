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
    flintPkgs = pkgs.writeShellApplication {
      name = "flint-pkgs";
      runtimeInputs = with pkgs; [
        fzf
        coreutils
        gawk
      ];
      text = builtins.readFile ./flint-pkgs.sh;
    };
  in {
    home.packages = with pkgs; [
      # Flint Package & Modules Cheatsheet
      flintPkgs

      # Nix search & info
      ns
      fastfetch
      areofyl-fetch

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
