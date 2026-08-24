{ config, lib, pkgs, inputs, ... }:

{
  imports = lib.optional (inputs ? stylix) inputs.stylix.nixosModules.stylix;

  stylix = {
    enable = true;
    autoEnable = true;
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      font-awesome
    ];
  };
}
