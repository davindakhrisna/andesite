{
  flake.homeModules.desktop-hyprsunset = {pkgs, ...}: {
    home.packages = with pkgs; [
      hyprsunset   # Blue-light filter & color temperature utility
      wlsunset     # Fallback blue-light daemon
    ];
  };
}
