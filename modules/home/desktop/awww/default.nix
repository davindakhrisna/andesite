{
  flake.homeModules.desktop-awww = {pkgs, ...}: {
    home.packages = with pkgs; [
      awww # Efficient animated wallpaper daemon for Wayland
    ];
  };
}
