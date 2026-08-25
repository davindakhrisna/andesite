{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    # System modules
    ../../modules/system/hardware.nix
    ../../modules/system/core.nix
    ../../modules/system/hyprland/hyprland.nix
    ../../modules/system/hyprland/quickshell.nix
    ../../modules/system/hyprland/stylix.nix

    # Active Theme
    ../../themes/andesite.nix
  ];

  networking.hostName = "powerhouse";
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  # User Account (System-level)
  users.users.kryisnn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "audio"
      "input"
      "docker"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  # Hardware
  var.cpu = "intel";
  var.gpu = "nvidia";
  var.nvidia.mode = "desktop";

  # User Configuration (Home Manager level)
  home-manager.users.kryisnn = { ... }: {
    imports = [
      ../../modules/home/home.nix
    ];
  };

  system.stateVersion = "26.05";
}
