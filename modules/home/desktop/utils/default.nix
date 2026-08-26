{
  flake.homeModules.utils = {
    pkgs,
    inputs,
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

      # Clipboard
      wl-clipboard
      cliphist

      # runtime deps
      adwaita-icon-theme
      qt6.qtdeclarative
      hyprsunset   # Blue-light filter & color temperature utility
      wlsunset     # Fallback blue-light daemon
    ];
  };
}
