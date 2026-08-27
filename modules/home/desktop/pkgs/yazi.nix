{
  flake.homeModules.desktop-yazi = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/yazi";
  in {
    home.packages = [ pkgs.yazi ];

    xdg.configFile."yazi/yazi.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/yazi.toml";
  };
}
