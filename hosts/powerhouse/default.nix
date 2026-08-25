{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.powerhouse = inputs.nixpkgs.lib.nixosSystem {
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
        };
      }
      ./_hardware.nix

      # System modules
      self.nixosModules.system

      # Active Theme
      self.nixosModules.theme-andesite

      # Host-specific Configuration
      ({pkgs, ...}: {
        networking.hostName = "powerhouse";
        time.timeZone = "Asia/Jakarta";
        i18n.defaultLocale = "en_US.UTF-8";

        # User Account (System-level)
        users.users.kryisnn = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "docker"
            "video"
            "audio"
            "input"
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
        home-manager.users.kryisnn = {...}: {
          imports = with self.homeModules; [
            base
            general
            hyprland
            dev
            dev-utils
            productivity
            productivity-utils
            utils
            gaming-steam
          ];
        };

        system.stateVersion = "26.05";
      })
    ];
  };
}
