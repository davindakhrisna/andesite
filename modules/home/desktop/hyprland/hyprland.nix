{
  flake.homeModules.hyprland = {osConfig, ...}: let
    theme =
      osConfig.theme or {
        rounding = 20;
        bar-height = 36;
        gaps-in = 8;
        gaps-out = 16;
        active-opacity = 0.96;
        inactive-opacity = 0.92;
        blur = true;
        border-size = 2;
        animation-speed = "very-fast";
      };
  in {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        general = {
          gaps_in = theme.gaps-in;
          gaps_out = theme.gaps-out;
          border_size = theme.border-size;
        };
        decoration = {
          inherit (theme) rounding;
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
  };
}
