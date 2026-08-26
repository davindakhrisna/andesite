{
  flake.nixosModules.hyprland = _: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Wayland session flags & display manager
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.displayManager.ly.enable = true;
  };
}
