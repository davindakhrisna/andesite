{
  flake.homeModules.desktop-lockscreen = {
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      hypridle
      hyprlock
      cmatrix
    ];
  };
}
