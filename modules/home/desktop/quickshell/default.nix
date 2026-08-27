{
  flake.homeModules.desktop-quickshell = {
    config,
    lib,
    pkgs,
    inputs,
    ...
  }: let
    quickshellDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/quickshell";
  in {
    home.packages = lib.optional (inputs ? quickshell) 
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

    xdg.configFile."quickshell".source = 
      config.lib.file.mkOutOfStoreSymlink "${quickshellDir}/src";

    home.sessionVariables = {
      QS_CONFIG_PATH = "${quickshellDir}/src";
    };

    home.sessionPath = [
      "${quickshellDir}/scripts"
    ];
  };
}
