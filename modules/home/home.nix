{
  flake.homeModules.base = _: {
    xdg.enable = true;
    home.stateVersion = "26.05";
    home.sessionVariables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };

    programs.home-manager.enable = true;

    # First-activation takeover: hm refuses to overwrite pre-existing dotfiles.
    gtk.gtk2.force = true;
  };
}
