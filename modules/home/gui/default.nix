{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    brave
    foot
    kitty
    rofi
    waybar
    hyprpaper
    xwallpaper
    xmobar
    adwaita-icon-theme
    qt6.qtdeclarative
  ] ++ (lib.optional (inputs ? quickshell) inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default);
}
