{
  flake.nixosModules.utils = {pkgs, ...}: {
    # Desktop packages
    programs.chromium.enable = true; # Also serve as fallback browser

    environment.systemPackages = with pkgs; [
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
