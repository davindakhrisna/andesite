{ self, ... }: {
  flake.homeModules.desktop = {
    lib,
    pkgs,
    inputs,
    ...
  }: {
    imports = with self.homeModules; [
      desktop-hyprland
      desktop-quickshell
      desktop-rofi
      desktop-hyprlock
      desktop-hyprsunset
      desktop-dunst
      desktop-awww
      desktop-helium
      desktop-wlogout
    ];

    home.packages = with pkgs;
    [
      # terminal
      foot
      kitty

      # password manager
      bitwarden-desktop

      # file manager
      thunar

      # Audio & Bluetooth
      wiremix      # PipeWire TUI audio mixer
      bluetui      # Bluetooth TUI manager
      
      # Network & WiFi
      gazelle-tui  # NetworkManager WiFi TUI

      # Display & Monitor Management
      hyprmon      # Hyprland Monitor layout & settings TUI
      wlr-randr    # Wayland xrandr equivalent (query & set displays)

      # Toolkit Screenshot
      grim         # Wayland screenshot tool
      slurp        # Screen region selector
      satty        # Modern screenshot editor & annotation tool
      swappy       # Lightweight image editor
      wl-screenrec # Hardware-accelerated screen recorder
    ];

    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
    };
  };
}
