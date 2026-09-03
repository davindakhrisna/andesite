{
  flake.homeModules.entertainment-social = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Voice & Chat
      vesktop # Discord with working Wayland screenshare + audio

      # Media & Audio
      spotify # Music
    ];
  };
}
