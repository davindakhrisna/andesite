{
  flake.nixosModules.system = {self, ...}: {
    imports = with self.nixosModules; [
      core
      hardware
      pkgs
      hyprland
      quickshell
      stylix
    ];
  };
}
