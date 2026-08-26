{
  flake.homeModules.desktop-hyprlock = _: {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 3;
          hide_cursor = true;
        };
        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        input-field = [
          {
            size = "250, 50";
            outline_thickness = 2;
            dots_center = true;
            fade_on_empty = false;
          }
        ];
      };
    };
  };
}
