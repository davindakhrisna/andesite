{
  flake.nixosModules.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'GameMode started' -i input-gaming";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'GameMode ended' -i input-gaming";
        };
      };
    };
  };
}
