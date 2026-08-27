{
  flake.homeModules.desktop-rofi = {
    pkgs,
    lib,
    config,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/rofi";
  in {
    home.packages = [
      pkgs.rofi
    ];

    xdg.configFile."rofi".source =
      config.lib.file.mkOutOfStoreSymlink cfgDir;

  };
}
