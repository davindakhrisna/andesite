{
  flake.homeModules.desktop-wallust = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/wallust";
  in {
    home.packages = [
      pkgs.wallust
    ];

    xdg.configFile."wallust".source =
      config.lib.file.mkOutOfStoreSymlink cfgDir;
  };
}
