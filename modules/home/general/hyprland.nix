{ osConfig, lib, pkgs, ... }: 
let
  border-size = config.theme.border-size;
  gaps-in = config.theme.gaps-in;
  gaps-out = config.theme.gaps-out;
  active-opacity = config.theme.active-opacity;
  inactive-opacity = config.theme.inactive-opacity;
  rounding = config.theme.rounding;
  blur = config.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
  background = "rgba(" + config.lib.stylix.colors.base00 + "EE)";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = theme.gaps-in;
        gaps_out = theme.gaps-out;
        border_size = theme.border-size;
      };
      decoration = {
        rounding = theme.rounding;
        active_opacity = theme.active-opacity;
        inactive_opacity = theme.inactive-opacity;
        blur = {
          enabled = theme.blur;
          size = 8;
          passes = 2;
        };
      };
    };
  };
}
