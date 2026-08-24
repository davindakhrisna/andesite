{
  imports = [
    ./dev
    ./gui
    ./utils
  ];

  xdg.enable = true;
  home.stateVersion = "26.05";
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;

  # First-activation takeover: hm refuses to overwrite pre-existing dotfiles.
  # gtk2's ~/.gtkrc-2.0 has a dedicated hm option; the stale gtk3/gtk4 files
  # (~/.config/gtk-{3,4}.0/{gtk.css,settings.ini}) were moved aside manually
  # on the machine during the takeover (backup: ~/flint-first-activation-backup).
  gtk.gtk2.force = true;
}