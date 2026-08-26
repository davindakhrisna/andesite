{
  flake.homeModules.desktop-quickshell = {
    lib,
    pkgs,
    inputs,
    ...
  }: {
    home.packages = lib.optional (inputs ? quickshell) 
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Links everything inside modules/home/desktop/quickshell/src/ -> ~/.config/quickshell/
    xdg.configFile."quickshell".source = ./src;
    xdg.configFile."quickshell".recursive = true;
  };
}
