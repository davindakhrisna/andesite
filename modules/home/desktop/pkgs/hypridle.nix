{
  flake.homeModules.desktop-hypridle = {
    config,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/hyprland";
  in {
    services.hypridle = {
      enable = true;
    };

    xdg.configFile."hypr/hypridle.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/hypridle.conf";
  };
}
