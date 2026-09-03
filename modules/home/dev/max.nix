_: {
  flake.homeModules.dev-max = {
    config,
    lib,
    pkgs,
    ...
  }: {
    config = lib.mkIf (config.dev == "max") {
      home = {
        packages = with pkgs; [
          # Mobile Development
          flutter
          jdk17
          android-tools

          # AI & Machine Learning Tools
          uv

          # Game Development & Asset Creation
          godot_4
          blender
          libresprite

          # Windows Apps & Compatibility
          winboat

          # Nix Utilities
          nix-prefetch-github
        ];

        sessionVariables = {
          # Android & Gradle
          ANDROID_USER_HOME = "$HOME/.local/share/android";
          GRADLE_USER_HOME = "$HOME/.local/share/gradle";
        };
      };
    };
  };
}
