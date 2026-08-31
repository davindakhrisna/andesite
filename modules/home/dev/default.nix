{ self, ... }: {
  imports = [
    ./min.nix
    ./mid.nix
    ./max.nix
  ];

  flake.homeModules = {
    dev = { config, lib, ... }: {
      options.dev = lib.mkOption {
        type = lib.types.enum [ "off" "min" "mid" "max" ];
        default = "mid";
        description = "Development environment tier: off, min, mid, or max";
      };

      config = lib.mkMerge [
        (lib.mkIf (config.dev == "min") {
          imports = [ self.homeModules.dev-min ];
        })
        (lib.mkIf (config.dev == "mid") {
          imports = [ self.homeModules.dev-mid ];
        })
        (lib.mkIf (config.dev == "max") {
          imports = [ self.homeModules.dev-max ];
        })
      ];
    };
  };
}
