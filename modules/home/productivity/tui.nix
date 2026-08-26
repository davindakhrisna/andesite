{
  flake.homeModules.productivity-tui = {pkgs, ...}: {
    home.packages = with pkgs; [
      # - custom OPDS epub/pdf reader (i will create it on my own) 
      hacker-news-tui # Y Combinator news maybe?
      basalt          # note taker
      pomo            # pomodoro
      sioyek          # technical research reader
    ];
  };
}
