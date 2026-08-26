{
  flake.homeModules.entertainment = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Voice & Chat
      vesktop           # Discord with working Wayland screenshare + audio

      # Media & Audio
      mpv               # Video player
      spotify           # Music
      easyeffects       # PipeWire audio equalizer/enhance
    ];
  };
}
