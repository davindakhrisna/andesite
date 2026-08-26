{
  flake.homeModules.utils-starship = {
    config,
    lib,
    ...
  }: let
    accent = "#${config.lib.stylix.colors.base0D}";
    background-alt = "#${config.lib.stylix.colors.base01}";
    muted = "#${config.lib.stylix.colors.base04}";
  in {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;

      settings = {
        format = ''
          [╭─ $shell──$nix_shell───────────── $memory_usage ──╌╌ $nodejs$python$golang$ocaml $fill ╌╌─╮](${muted})
          [├╌](${muted})$sudo$username$hostname$localip$directory$read_only$git_branch$git_commit$git_metrics [$fill $cmd_duration ┘](${muted})
          [╰─ $battery $character](${muted}) '';

        character = {
          success_symbol = "[❯](${accent})";
          error_symbol = "[❯](<bold red>)";
        };

        directory = {
          style = "bold ${accent}";
          truncation_length = 4;
          truncate_to_repo = true;
        };

        git_branch = {
          symbol = " ";
          style = "bold ${accent}";
        };

        nix_shell = {
          symbol = "❄️ ";
          format = "via [$symbol$state](${accent}) ";
        };

        cmd_duration = {
          min_time = 500;
          format = "took [$duration](${accent})";
        };
      };
    };
  };
}
