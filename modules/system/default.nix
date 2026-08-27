{
  flake.nixosModules.system = {self, ...}: {
    imports = with self.nixosModules; [
      base
      gaming
      hardware
      desktop
      utils
    ];
  };
}
