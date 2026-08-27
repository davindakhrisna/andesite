{
  flake.homeModules.desktop-kitty = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/kitty";
  in {
    home.packages = [
      pkgs.kitty
    ];

    xdg.configFile."kitty".source =
      config.lib.file.mkOutOfStoreSymlink cfgDir;

  };
}
