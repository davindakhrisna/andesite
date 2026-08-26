{
  flake.homeModules.dev-utils = {pkgs, ...}: {
    # Editors
    programs.zed-editor = {
      enable = true;
      userSettings = {
        tab_size = 4;
        vim_mode = true;
        cursor_blink = true;
      };
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };

    home.packages = with pkgs; [
      # GUI Dev Tools
      dbgate
      bruno

      # AI
      google-antigravity-ide
      opencode
    ];
  };
}
