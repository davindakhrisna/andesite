{
  flake.homeModules.dev = {
    config,
    pkgs,
    ...
  }: let
    mkenv = pkgs.writeShellApplication {
      name = "mkenv";
      runtimeInputs = with pkgs; [
        fzf
        git
        direnv
        coreutils
        gawk
        libnotify
      ];
      text = builtins.readFile ./mkenv.sh;
    };
  in {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "davindakhrisna";
          email = "arpeggio.gns@gmail.com";
        };
        init.defaultBranch = "main";
        safe.directory = [ "${config.home.homeDirectory}/.config/flint" "*" ];
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

    home = {
      packages = with pkgs; [
        # Nix-Direnv Bootstrapper
        mkenv

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
        jq
        netcat-gnu
        alejandra
        nixfmt
        nix-prefetch-github
      ];

      sessionPath = ["$HOME/.local/share/go/bin"];
      sessionVariables = {
        # Go
        GOPATH = "$HOME/.local/share/go";
        GOMODCACHE = "$HOME/.cache/go/mod";

        # Android & Gradle
        ANDROID_USER_HOME = "$HOME/.local/share/android";
        GRADLE_USER_HOME = "$HOME/.local/share/gradle";

        # Node & NPM
        NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
        NPM_CONFIG_CACHE = "$HOME/.cache/npm";
        NODE_REPL_HISTORY = "$HOME/.local/state/node_repl_history";

        # Python
        PYTHONSTARTUP = "$HOME/.config/python/pythonrc";
        IPYTHONDIR = "$HOME/.config/ipython";
        JUPYTER_CONFIG_DIR = "$HOME/.config/jupyter";
      };
    };
  };
}
