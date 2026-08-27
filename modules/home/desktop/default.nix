{ self, ... }: {
  imports = [
    ./pkgs/base.nix
    ./pkgs/hyprland.nix
    ./pkgs/waybar.nix
    ./pkgs/wallpaper.nix
    ./pkgs/lockscreen.nix
    ./pkgs/dunst.nix
    ./pkgs/swayosd.nix
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
      desktop-lockscreen
      desktop-dunst
      desktop-swayosd
      desktop-base
    ];
  };
}
