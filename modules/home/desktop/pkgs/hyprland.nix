{
  flake.homeModules.desktop-hyprland = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/hyprland";
  in {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
    };

    xdg.configFile."hypr/hyprland.lua".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/hyprland.lua"
    );

    xdg.configFile."hypr/bindings.lua".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/bindings.lua"
    );

    home.sessionPath = [
      "${cfgDir}/scripts"
    ];
  };
}