{
  flake.homeModules.desktop-rofi = {
    pkgs,
    lib,
    config,
    ...
  }: let
    rofiDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/rofi";
  in {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      terminal = "${pkgs.kitty}/bin/kitty";
      theme = "${rofiDir}/theme.rasi";
      extraConfig = {
        modi = "drun,run,window";
        show-icons = true;
        drun-display-format = "{name}";
      };
    };

    xdg.configFile."rofi/theme.rasi".source =
      config.lib.file.mkOutOfStoreSymlink "${rofiDir}/theme.rasi";

    # Disable Stylix's automatic rofi theming so custom theme.rasi is used
    stylix.targets.rofi.enable = false;
  };
}
