{
  flake.homeModules.productivity = {
    pkgs,
    ...
  }: {
    services.flatpak = {
      enable = true;
      packages = [
        "com.obsproject.Studio"
      ];
    };

    home.packages = with pkgs; [
      # TUI Productivity Suite
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
