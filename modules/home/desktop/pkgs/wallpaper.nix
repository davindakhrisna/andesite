{
  flake.homeModules.desktop-wallpaper = {
    pkgs,
    ...
  }: {
    home.packages = [
      pkgs.wallust
      pkgs.awww
    ];
  };
}
