{
  flake.homeModules.productivity = {pkgs, ...}: {
    programs.git = {
      enable = true;
    };

    home.packages = with pkgs; [
      tmux
      alejandra
      nix-direnv
    ];
  };
}
