{
  flake.homeModules.desktop-wlogout = {
    config,
    lib,
    ...
  }: let
    wlogoutDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/wlogout";
  in {
    programs.wlogout.enable = true;

    xdg.configFile."wlogout/layout".source = 
      config.lib.file.mkOutOfStoreSymlink "${wlogoutDir}/layout";

    xdg.configFile."wlogout/style.css".source = 
      config.lib.file.mkOutOfStoreSymlink "${wlogoutDir}/style.css";
  };
}
