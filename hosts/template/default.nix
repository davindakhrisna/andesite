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
            inputs.nvf.homeManagerModules.default
          ];
        };
      }
      ./_hardware.nix

      # System modules
      self.nixosModules.system

      # Host-specific Configuration
      ({pkgs, ...}: { # CHANGEME
        networking.hostName = "template"; # CHANGEME: Hostname
        time.timeZone = "Asia/Jakarta";   # CHANGEME: Timezone
        i18n.defaultLocale = "en_US.UTF-8";
        programs.nh.flake = "/home/yourusername/.config/flint"; # CHANGEME: Path to your flint flake

        # User Account (System-level)
        users.users.yourusername = { # CHANGEME: Username
          isNormalUser = true;
          shell = pkgs.zsh;
          extraGroups = [
            "wheel"
            "networkmanager"
            "docker"
            "video"
            "audio"
            "input"
            "adbusers"
          ];
        };

        # Hardware 
        var = { # CHANGEME (your hardware specs)
          cpu = "intel";
          gpu = "nvidia";
          nvidia.mode = "desktop"; # ["desktop" "offload" "sync"] -- or just comment it if you dont use nvidia
        };

        # User Configuration (Home Manager level)
        home-manager.users.yourusername = {...}: { # CHANGEME (to your liking)
          imports = with self.homeModules; [
            home-manager
            desktop
            shell
            productivity
            extra-pkgs

            # Dev Modules
            dev             # languages, package managers, cli tools
            dev-nvf         # modular neovim framework (nvf)
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
