{
  flake.homeModules.productivity = {
    pkgs,
    ...
  }: let
    # TUI Productivity tools runtime dependencies
    tuiPackages = with pkgs; [
      basalt          # Primary Note taker
      hackernews-tui  # Y Combinator news reader
      pomo            # Pomodoro focus timer
    ];

    # Custom Multi-TUI Workspace Runner
    basaltix = pkgs.writeShellApplication {
      name = "basaltix";
      runtimeInputs = with pkgs; [
        tmux
        fzf
        coreutils
        gawk
      ] ++ tuiPackages;
      text = builtins.readFile ./basaltix.sh;
    };
  in {
    home.packages = with pkgs; [
      # Custom Workspace Runner
      basaltix

      # TUI Productivity Suite
      # custom OPDS
      hackernews-tui
      basalt
      pomo
      sioyek
      pi-coding-agent

      # GUI
      obsidian
      xournalpp
      onlyoffice-desktopeditors
      pdfarranger
      freecad
    ];
  };
}
