{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    # System modules
    ../../modules/system/core.nix
    ../../modules/system/hyprland/hyprland.nix
    ../../modules/system/quickshell.nix
    # ../../modules/system/stylix.nix
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
