{
  flake.homeModules.desktop-wallpaper = {
    pkgs,
    ...
  }: {
    home.packages = [
      pkgs.awww
    ];
  };
}
