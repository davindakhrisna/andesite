{
  flake.homeModules.desktop-hyprlock = {
    config,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/hyprland";
  in {
    programs.hyprlock = {
      enable = true;
    };

    xdg.configFile."hypr/hyprlock.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/hyprlock.conf";
  };
}