{ config, pkgs, ... }:

let
  ns = pkgs.writeShellApplication {
    name = "ns";
    runtimeInputs = with pkgs; [
      fzf
      (nix-search-tv.overrideAttrs {
        env.GOEXPERIMENT = "jsonv2";
      })
    ];
    text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
  };
in
{
  home.packages = with pkgs; [
    ns
    fastfetch
    nitch
    eza
    fzf
  ];
}
