{
  flake.homeModules.utils-tui = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Audio & Bluetooth
      wiremix      # PipeWire TUI audio mixer
      bluetui      # Bluetooth TUI manager
      
      # Network & WiFi
      gazelle-tui  # NetworkManager WiFi TUI

      # Display & Monitor Management
      hyprmon      # Hyprland Monitor layout & settings TUI
      wlr-randr    # Wayland xrandr equivalent (query & set displays)
    ];

    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
    };
  };
}
