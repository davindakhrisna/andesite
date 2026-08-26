{
  flake.homeModules.productivity-gui = {pkgs, inputs, ...}: {
    home.packages = with pkgs; [
      obsidian        # note taking
      xournalpp       # draw
      onlyoffice-bin  # great compatibility with ms-office
      masterpdfeditor # advanced pdf text editor
    ];
  };
}
