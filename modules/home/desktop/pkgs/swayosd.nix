{
  flake.homeModules.desktop-swayosd = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/swayosd";
  in {
    services.swayosd = {
      enable = true;
      stylePath = "${cfgDir}/style.css";
    };
  };
}
