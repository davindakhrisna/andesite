{
  flake.nixosModules.theme-andesite = {
    lib,
    pkgs,
    ...
  }: {
    options.theme = lib.mkOption {
      type = lib.types.attrs;
      default = {
        rounding = 20;
        bar-height = 36;
        gaps-in = 8;
        gaps-out = 8 * 2;
        active-opacity = 0.96;
        inactive-opacity = 0.92;
        blur = true;
        border-size = 2;
        animation-speed = "very-fast"; # "very-fast" | "fast" | "medium" | "slow"
      };
      description = "Theme configuration options";
    };

    config.stylix = {
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
        size = 20;
      };

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
          applications = 13;
          desktop = 13;
          popups = 13;
          terminal = 13;
        };
      };

      polarity = "dark";
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/anotherhadi/awesome-wallpapers/main/wallpapers/the-cpu_animated_black.gif";
        sha256 = "sha256-peigNzQDxvDqRCz9f0PPaejiAafD1o1q8H6kVpazhRE=";
      };
    };
  };
}
