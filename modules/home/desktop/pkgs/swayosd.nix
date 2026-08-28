{
  flake.homeModules.desktop-swayosd = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/swayosd";
  in {
    services.swayosd = {
      enable = true;
      stylePath = "${cfgDir}/style.css";
    };

    xdg.configFile."swayosd/style.css".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/style.css"
    );
    xdg.configFile."swayosd/config.toml".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/config.toml"
    );
  };
}
