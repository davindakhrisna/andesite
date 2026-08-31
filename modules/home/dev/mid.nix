{ self, ... }: {
  flake.homeModules.dev-mid = {
    pkgs,
    ...
  }: {
    imports = [
      self.homeModules.dev-min
    ];

    # Editors
    programs.zed-editor = {
      enable = true;
      userSettings = {
        tab_size = 4;
        vim_mode = true;
        cursor_blink = true;
      };
    };

    home = {
      packages = with pkgs; [
        # Web & General Dev Languages
        go
        nodejs
        python3

        # Package Managers & Process Runners
        pnpm
        air

        # Containers & Networking Dev Tools
        lazydocker
        netcat-gnu

        # GUI Dev & Database Tools
        dbgate
        bruno

        # Agentic AI & IDE
        google-antigravity-ide
        opencode
      ];

      sessionPath = ["$HOME/.local/share/go/bin"];
      sessionVariables = {
        # Go
        GOPATH = "$HOME/.local/share/go";
        GOMODCACHE = "$HOME/.cache/go/mod";

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
