{
  flake.homeModules.desktop-waybar = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/waybar";
  in {
    programs.waybar = {
      enable = true;
    };

    xdg.configFile."waybar/config.jsonc".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/config.jsonc"
    );

    xdg.configFile."waybar/style.css".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/style.css"
    );
  };
}
