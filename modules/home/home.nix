{
  flake.homeModules.home-manager = {
    config,
    lib,
    pkgs,
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
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      font = {
        name = "Iosevka Nerd Font";
        size = 12;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk2.force = true;
    };

    home.pointerCursor = {
      enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "adw-gtk3-dark";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Bibata-Modern-Ice";
        cursor-size = 24;
        font-name = "Iosevka Nerd Font 12";
        document-font-name = "Iosevka Nerd Font 12";
        monospace-font-name = "Iosevka Nerd Font 12";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style.name = "adwaita-dark";
    };

    xresources.path = "${config.xdg.configHome}/X11/Xresources";

    # Prevent Home Manager from linking legacy dotfiles directly in $HOME root
    home.file = {
      ".zshenv".enable = false;
    } // (lib.optionalAttrs (config.gtk.theme.name != null) {
      ".themes/${config.gtk.theme.name}".enable = false;
    });

    programs.home-manager.enable = true;
  };
}
