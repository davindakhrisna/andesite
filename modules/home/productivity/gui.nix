{
  flake.homeModules.productivity-gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      obsidian        # note taking
      xournalpp       # draw
      onlyoffice-desktopeditors # great compatibility with ms-office
      # masterpdfeditor # upstream vendor 404 on current version tarball
      pdfarranger     # PDF merge, split, rotate and edit tool
      freecad         # 3D parametric CAD modeler
    ];
  };
}
