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

    # AI
    home.packages = with pkgs; [
      google-antigravity-ide
    ];
  };
}
