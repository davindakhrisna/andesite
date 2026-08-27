{
  flake.homeModules.desktop-hypridle = _: {
    services.hypridle = {
      enable = true;
    };
  };
}
