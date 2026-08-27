{ self, ... }: {
  imports = [
    ./pkgs/base.nix
    ./pkgs/hyprland.nix
    ./pkgs/waybar.nix
    ./pkgs/wallpaper.nix
    ./pkgs/awww.nix
  ];

  flake.homeModules.desktop = {
    lib,
    pkgs,
    inputs,
    config,
    ...
  }: {
    imports = with self.homeModules; [
      desktop-hyprland
      desktop-waybar
      desktop-wallpaper
      desktop-base
    ];
  };
}
