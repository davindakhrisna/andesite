{
  flake.nixosModules.stylix = {
    lib,
    pkgs,
    inputs,
    ...
  }: {
    imports = lib.optional (inputs ? stylix) inputs.stylix.nixosModules.stylix;

    stylix = {
      enable = true;
      autoEnable = true;

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
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        font-awesome
        nerd-fonts.symbols-only
      ];
    };
  };
}
