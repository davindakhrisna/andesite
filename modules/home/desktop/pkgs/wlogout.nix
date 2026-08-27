{
  flake.homeModules.desktop-wlogout = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/wlogout";
  in {
    home.packages = [
      pkgs.wlogout
    ];

    xdg.configFile."wlogout".source =
      config.lib.file.mkOutOfStoreSymlink cfgDir;
  };
}