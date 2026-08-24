{ config, pkgs, ... }:

{
  imports = [
    ./utils.nix
  ];

  programs.git = {
    enable = true;
  };

  home.packages = with pkgs; [
    tmux
    alejandra
    nix-direnv
  ];
}
