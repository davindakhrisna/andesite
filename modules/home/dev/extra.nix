{
  flake.homeModules.dev-extra = {pkgs, ...}: {
    home.packages = with pkgs; [
      # AI & Machine Learning
      uv

      # Game Development & Asset Creation
      godot_4
      blender
      libresprite
    ];
  };
}
