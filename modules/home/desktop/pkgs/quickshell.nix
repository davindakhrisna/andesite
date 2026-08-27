{
  flake.homeModules.desktop-quickshell = {
    config,
    lib,
    pkgs,
    inputs,
    ...
  }: let
    cfgDir = "${config.home.homeDirectory}/.config/flint/modules/home/desktop/config/quickshell";
  in {
    home.packages = (lib.optional (inputs ? quickshell)
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default) ++ (with pkgs; [
      brightnessctl
      playerctl
      lm_sensors
      libnotify
    ]);

    xdg.configFile."quickshell".source =
      config.lib.file.mkOutOfStoreSymlink cfgDir;

    home.sessionVariables = {
      QS_CONFIG_PATH = cfgDir;
    };

    home.sessionPath = [
      "${cfgDir}/scripts"
    ];
  };
}
