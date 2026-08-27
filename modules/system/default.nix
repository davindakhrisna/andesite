{
  flake.nixosModules.system = {self, ...}: {
    imports = with self.nixosModules; [
      core
      gaming
      hardware
      hyprland
      pkgs
      stylix
    ];
  };
}
