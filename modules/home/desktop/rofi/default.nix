{
  flake.homeModules.desktop-rofi = {pkgs, ...}: {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "${pkgs.kitty}/bin/kitty";
      extraConfig = {
        modi = "drun,run,window";
        show-icons = true;
        drun-display-format = "{name}";
      };
    };

    # Link custom theme from this folder
    xdg.configFile."rofi/theme.rasi".source = ./theme.rasi;
  };
}
