{
  flake.homeModules.desktop-hyprland = {
    config,
    lib,
    ...
  }: let
    hyprlandDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/hyprland";
  in {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
    };

    xdg.configFile."hypr/hyprland.lua".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${hyprlandDir}/src/hyprland.lua"
    );

    home.sessionPath = [
      "${hyprlandDir}/scripts"
    ];
  };
}
