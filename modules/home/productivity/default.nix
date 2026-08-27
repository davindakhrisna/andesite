{
  flake.homeModules.productivity = {pkgs, ...}: {
    home.packages = with pkgs; [
      # TUI
      # - custom OPDS epub/pdf reader (i will create it on my own) 
      hacker-news-tui # Y Combinator news maybe?
      basalt          # note taker
      pomo            # pomodoro
      sioyek          # technical research reader

      # GUI
      obsidian        # note taking
      xournalpp       # draw
      onlyoffice-desktopeditors # great compatibility with ms-office
      # masterpdfeditor # upstream vendor 404 on current version tarball
      pdfarranger     # PDF merge, split, rotate and edit tool
      freecad         # 3D parametric CAD modeler
    ];
  };
}
