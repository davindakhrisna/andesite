{
  flake.homeModules.desktop-hyprland = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/hyprland";
    lckDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/lockscreen";
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

    xdg.configFile."hypr/hypridle.conf".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${lckDir}/hypridle.conf"
    );

    xdg.configFile."hypr/hyprlock.conf".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${lckDir}/hyprlock.conf"
    );

    home.sessionPath = [
      "${cfgDir}/scripts"
    ];
  };
}