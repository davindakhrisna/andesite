{
  flake.homeModules.extra-pkgs = {pkgs, ...}: {
    services.flatpak = {
      enable = true;
      packages = [
        "com.obsproject.Studio"
        "org.vinegarhq.Sober"
      ];
    };

    home.packages = with pkgs; [
      winboat
    ];
  };
}
