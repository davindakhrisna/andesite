{
  flake.homeModules.desktop-dunst = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/dunst";
  in {
    services.dunst = {
      enable = true;
      configFile = "${cfgDir}/dunstrc";
    };
  };
}
