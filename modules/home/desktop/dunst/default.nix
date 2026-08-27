{
  flake.homeModules.desktop-dunst = _: {
    services.dunst = {
      enable = true;
      # 
      # STILL DECIDING WHAT TO BE HERE
      # 
      # settings = {
      #   global = {
      #     follow = "mouse";
      #     width = 320;
      #     height = 120;
      #     origin = "top-right";
      #     offset = "20x20";
      #     corner_radius = 12;
      #     frame_width = 2;
      #     gap_size = 8;
      #     notification_limit = 5;
      #   };
      #   urgency_low = {
      #     timeout = 4;
      #   };
      #   urgency_normal = {
      #     timeout = 6;
      #   };
      #   urgency_critical = {
      #     timeout = 0;
      #   };
      # };
    };
  };
}
