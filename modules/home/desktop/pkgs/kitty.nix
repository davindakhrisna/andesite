{
  flake.homeModules.desktop-kitty = {
    config,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/kitty";
  in {
    home.packages = [
      pkgs.kitty
    ];

    xdg.configFile."kitty".source =
      config.lib.file.mkOutOfStoreSymlink cfgDir;

    # Disable Stylix auto-generating kitty colors so custom kitty.conf is used
    stylix.targets.kitty.enable = false;
  };
}
