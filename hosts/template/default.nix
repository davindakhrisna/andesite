{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    # System modules
    ../../modules/system/core.nix
    # ../../modules/system/hyprland/hyprland.nix
  ];

  networking.hostName = "template";
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  # User Account (System-level)
  users.users.yourusername = {
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
  var.cpu = "intel";   # "intel" | "amd"
  var.gpu = "nvidia";  # "nvidia" | "amd" | "intel"
  # If using Nvidia:
  # var.nvidia.mode = "desktop";  # Dedicated Desktop GPU (default)
  # var.nvidia.mode = "offload";  # Laptop Hybrid (Power Saver)
  # var.nvidia.mode = "sync";     # Laptop Hybrid (Max Performance)

  # User Configuration (Home Manager level)
  home-manager.users.yourusername = { ... }: {
    imports = [
      ../../modules/home/home.nix
    ];
  };

  system.stateVersion = "26.05";
}
