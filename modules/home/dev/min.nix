{ self, ... }: {
  flake.homeModules.dev-min = {
    config,
    pkgs,
    osConfig ? {},
    ...
  }: {
    imports = [
      ./_nvf.nix
    ];

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "davindakhrisna";
          email = "arpeggio.gns@gmail.com";
        };
        init.defaultBranch = "main";
        safe.directory = [ (osConfig.var.flakePath or "${config.home.homeDirectory}/.config/flint") "*" ];
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      # Core Build & Compiler Tools
      gcc
      gnumake
      pkg-config

      # Core Database CLI
      sqlite

      # Core CLI & TUI Dev Tools
      lazygit
      jq
      alejandra
      nixfmt
    ];
  };
}
