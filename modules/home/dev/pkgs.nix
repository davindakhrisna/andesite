{
  flake.homeModules.dev = {
    pkgs,
    ...
  }: {
    programs.git = {
      enable = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      # Web & General Dev Languages
      go
      nodejs
      python3

      # Mobile Development
      flutter
      jdk17
      android-tools

      # Package Managers & Build Tools
      pnpm
      air
      gcc
      gnumake
      pkg-config

      # Database
      sqlite

      # CLI & TUI Dev Tools
      lazygit
      lazydocker
      gh
      jq
      alejandra
      nix-prefetch-github
    ];

    sessionPath = ["$HOME/.local/share/go/bin"];
    sessionVariables.GOPATH = "$HOME/.local/share/go";
  };
}
