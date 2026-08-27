{
  flake.homeModules.desktop-dunst = _: {
    services.dunst = {
      enable = true;
    };
  };
}