{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.template = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs self;};
    modules = [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs self;};
          backupFileExtension = "backup";
          sharedModules = [
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };
      }
      ./_hardware.nix

      # System modules
      self.nixosModules.system

      # Host-specific Configuration
      ({pkgs, ...}: {
        networking.hostName = "template";
        time.timeZone = "Asia/Jakarta";
        i18n.defaultLocale = "en_US.UTF-8";

        # User Account (System-level)
        users.users.yourusername = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "docker"
            "video"
            "audio"
            "input"
            "adbusers"
          ];
          packages = with pkgs; [
            tree
          ];
        };

        # Hardware
        var = {
          cpu = "intel";
          gpu = "nvidia";
          nvidia.mode = "desktop";
        };

        # User Configuration (Home Manager level)
        home-manager.users.yourusername = {...}: {
          imports = with self.homeModules; [
            # Base -- !DO NOT TOUCH!
            desktop
            home-manager

            # 
            utils
            utils-zsh
            utils-starship
            productivity-tui
            productivity-gui
            extra-pkgs

            # Dev Modules
            dev             # languages, package managers, cli tools
            dev-utils       # agentic AI, db management, editors
            dev-extra       # game dev and local AI stuff

            # Entertainment
            entertainment-social
            entertainment-gaming
          ];
        };

        system.stateVersion = "26.05";
      })
    ];
  };
}
