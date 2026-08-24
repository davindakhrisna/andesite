{ config, lib, pkgs, ... }:

{
  # Desktop packages
  programs.chromium.enable = true;

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
  ];
}
