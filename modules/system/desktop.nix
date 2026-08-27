{
  flake.nixosModules.desktop = {
    lib,
    pkgs,
    inputs,
    ...
  }: {
    # Hyprland UWSM
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Wayland session flags & display manager
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    services.displayManager.ly.enable = true;

    # PAM authentication for Hyprlock (instant zero-delay login)
    security.pam.services.hyprlock = {};

    # Global Fonts & Glyphs
    fonts = {
      fontconfig.enable = true;
      packages = with pkgs; [
        nerd-fonts.iosevka
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        font-awesome
        nerd-fonts.symbols-only
      ];
    };
  };
}
