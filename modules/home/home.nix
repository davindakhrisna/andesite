{
  flake.homeModules.home-manager = {
    config,
    lib,
    ...
  }: {
    xdg.enable = true;
    home.stateVersion = "26.05";
    home.sessionVariables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
      ZDOTDIR = "${config.xdg.configHome}/zsh";

      # NVIDIA & OpenGL cache
      CUDA_CACHE_PATH = "$HOME/.cache/nv";
      __GL_SHADER_DISK_CACHE_PATH = "$HOME/.cache/nv";

      # XCompose cache
      XCOMPOSECACHE = "$HOME/.cache/X11/compose";

      # Shell & tool history / configs
      HISTFILE = "$HOME/.local/state/bash/history";
      WGETRC = "$HOME/.config/wgetrc";
      DOCKER_CONFIG = "$HOME/.config/docker";
      SQLITE_HISTORY = "$HOME/.local/state/sqlite_history";

      # Rust
      CARGO_HOME = "$HOME/.local/share/cargo";
      RUSTUP_HOME = "$HOME/.local/share/rustup";
    };

    # Relocate .gtkrc-2.0 and .Xresources away from $HOME
    gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    xresources.path = "${config.xdg.configHome}/X11/Xresources";

    # Prevent Home Manager from linking legacy dotfiles directly in $HOME root
    home.file = {
      ".zshenv".enable = false;
    } // (lib.optionalAttrs (config.gtk.theme.name != null) {
      ".themes/${config.gtk.theme.name}".enable = false;
    });

    programs.home-manager.enable = true;

    # First-activation takeover: hm refuses to overwrite pre-existing dotfiles.
    gtk.gtk2.force = true;
  };
}
