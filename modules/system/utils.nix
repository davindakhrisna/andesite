{
  flake.nixosModules.utils = {pkgs, ...}: {
    # Desktop packages
    programs.chromium.enable = true; # Also serve as fallback browser

    environment.systemPackages = with pkgs; [
      # Terminal
      kitty

      # Development Tools
      htop
      nix-index
      unzip

      # Utilities
      wget
      tmux
      psmisc        # provides killall, pstree, fuser
    ];
  };
}
