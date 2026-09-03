{self, ...}: {
  imports = [
    ./min.nix
    ./mid.nix
    ./max.nix
  ];

  flake.homeModules = {
    dev = {lib, ...}: {
      options.dev = lib.mkOption {
        type = lib.types.enum ["off" "min" "mid" "max"];
        default = "mid";
        description = "Development environment tier: off, min, mid, or max";
      };

      imports = with self.homeModules; [
        dev-min
        dev-mid
        dev-max
      ];
    };
  };
}
