# Includes :
# - Vulnix
# - Kernel Hardening
# - Bootloader
# - Network Setup
# - Audio
# - Bluetooth
# - Auto Nix (Garbage Collector)
# - Overlays

{ config, lib, pkgs, inputs, ... }:

{
  # Kernel Hardening
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.perf_event_paranoid" = 3;
    "kernel.yama.ptrace_scope" = 2;

    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv6.conf.all.accept_ra" = 0;

    "fs.protected_hardlinks" = 1;
    "fs.protected_symlinks" = 1;
    "fs.suid_dumpable" = 0;
  };

  # Bootloader (Limine EFI)
  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network Setup
  services.tailscale.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.backend = "wpa_supplicant";
  };

  # Audio Setup (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth Setup
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Auto Nix
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    permittedInsecurePackages = [
      "electron-40.10.5"
    ];
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = false;
    settings = {
      warn-dirty = false;
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Vulnix
  systemd = {
    services.vulnix = {
      description = "vulnix CVE scan";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.vulnix}/bin/vulnix --system";
        Nice = 20;
        IOSchedulingClass = "idle";
      };
    };
    timers.vulnix = {
      description = "Weekly vulnix CVE scan";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        RandomizedDelaySec = "2h";
      };
    };
  };

  # ------- Overlays ------- #

  nixpkgs.overlays = [
    inputs.antigravity-nix.overlays.default
  ];
}
