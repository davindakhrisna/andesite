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
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.displayManager.ly.enable = true;
  
    # Stylix
    imports = lib.optional (inputs ? stylix) inputs.stylix.nixosModules.stylix;
    stylix = {
      enable = true;
      autoEnable = true;
      polarity = "dark";

      fonts = {
        monospace = {
          package = pkgs.maple-mono.NF;
          name = "Maple Mono NF";
        };
        sansSerif = {
          package = pkgs.rubik;
          name = "Rubik";
        };
        serif = {
          package = pkgs.rubik;
          name = "Rubik";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          applications = 12;
          desktop = 12;
          popups = 12;
          terminal = 12;
        };
      };

      # Wallpaper Fallback
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/main/wallpapers/the-cpu_animated_black.gif";
        sha256 = "sha256-peigNzQDxvDqRCz9f0PPaejiAafD1o1q8H6kVpazhRE=";
      };
    };

    # Global Fonts & Glyphs
    fonts = {
      fontconfig.enable = true;
      packages = with pkgs; [
        maple-mono.NF
        rubik
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        font-awesome
        nerd-fonts.symbols-only
      ];
    };
  };
}
