{
  flake.homeModules.desktop = {
    lib,
    pkgs,
    inputs,
    ...
  }: {
    imports = with self.homeModules; [
      desktop-hyprland
      desktop-quickshell
      desktop-rofi
      desktop-hyprlock
      desktop-hyprsunset
      desktop-dunst
      desktop-wlogout
      desktop-clipboard
      desktop-screenshots
    ];

    home.packages = with pkgs;
      [
        # browser
        helium
        
        # terminal
        foot
        kitty

        # password manager
        bitwarden
      ]
      ++ (lib.optional (inputs ? quickshell) inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default);
  };
}
