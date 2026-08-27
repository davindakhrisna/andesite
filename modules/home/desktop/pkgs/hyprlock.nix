{
  flake.homeModules.desktop-hyprlock = _: {
    programs.hyprlock = {
      enable = true;
    };
  };
}