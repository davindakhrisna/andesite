{
  flake.homeModules.entertainment-gaming = {pkgs, ...}: {
    programs.mangohud = {
      enable = true;
      enableSessionWide = false;
      settings = {
        fps_limit = [ 0 144 60 ];
        toggle_fps_limit = "F1";
        toggle_hud = "Shift_R+F12";
        
        cpu_stats = true;
        cpu_temp = true;
        gpu_stats = true;
        gpu_temp = true;
        ram = true;
        vram = true;
        fps = true;
        frametime = true;
        frame_timing = 1;
      };
    };

    home.packages = with pkgs; [
      # Game Compatibility & Launchers
      mangohud
      protonup-qt   
      heroic            
      gamescope
    ];
  };
}
