{
  flake.homeModules.desktop-btop = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/btop";
  in {
    home.packages = [ pkgs.btop ];

    xdg.configFile."btop/btop.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/btop.conf";
  };
}
