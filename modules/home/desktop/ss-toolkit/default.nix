{
  flake.homeModules.desktop-screenshots = {pkgs, ...}: {
    home.packages = with pkgs; [
      grim         # Wayland screenshot tool
      slurp        # Screen region selector
      satty        # Modern screenshot editor & annotation tool
      swappy       # Lightweight image editor
      wl-screenrec # Hardware-accelerated screen recorder
    ];
  };
}