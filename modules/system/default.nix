{
  flake.nixosModules.system = {self, ...}: {
    imports = with self.nixosModules; [
      core
      hardware
      pkgs
      hyprland
      stylix
      gaming
    ];
  };
}
