{
  flake.nixosModules.pkgs = {pkgs, ...}: {
    # Desktop packages
    programs.chromium.enable = true; # Also serve as fallback browser

    environment.systemPackages = with pkgs; [
      # Text Editors
      kitty

      # Development Tools
      htop
      nix-index
      unzip

      # Utilities
      wget
      curl
      git
      tmux
    ];
  };
}
