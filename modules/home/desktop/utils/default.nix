{ self, ... }: {
  flake.homeModules.utils = {
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
    imports = with self.homeModules; [
      utils-starship
      utils-zsh
    ];

    home.packages = with pkgs; [
      ns            # nix search
      areofyl-fetch # animated fetch
      appimage-run  # Runs AppImages seamlessly on NixOS
      fastfetch
      fzf

      # Modern replacements
      zoxide  # cd
      bat     # cat
      duf     # df
      eza     # ls

      # Desktop Level
      playerctl
      brightnessctl

      # Media
      yt-dlp
      ffmpeg
      easyeffects
      mpv

      # Clipboard
      wl-clipboard
      cliphist

      # runtime deps
      adwaita-icon-theme
      qt6.qtdeclarative
      hyprsunset   # Blue-light filter & color temperature utility
      wlsunset     # Fallback blue-light daemon
      libnotify
    ];

    services.udiskie = {
      enable = true;
      notify = true;
      automount = true;
      tray = "never";
    };
  };
}
