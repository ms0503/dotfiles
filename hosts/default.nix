inputs: let
  mkHomeManagerConfiguration = {modules, overlays, system, username}: inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = {
      inherit inputs username;
    };
    modules = modules ++ [
      {
        home = {
          homeDirectory = "/home/${username}";
          inherit username;
          stateVersion = "22.11";
        };
        programs = {
          git.enable = true;
          home-manager.enable = true;
        };
      }
    ];
    pkgs = import inputs.nixpkgs {
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };
      inherit overlays system;
    };
  };
  mkNixosSystem = {hostname, modules, system, username}: inputs.nixpkgs.lib.nixosSystem {
    inherit modules system;
    specialArgs = {
      inherit hostname inputs username;
    };
  };
in {
  home-manager = {
    "ms0503@mainpc" = mkHomeManagerConfiguration {
      modules = [
        ./mainpc/home-manager.nix
      ];
      overlays = [
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
    "ms0503@rtex" = mkHomeManagerConfiguration {
      modules = [
        ./rtex/home-manager.nix
      ];
      overlays = [
        inputs.rust-overlay.overlays.default
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
    "ms0503@tp-x280" = mkHomeManagerConfiguration {
      modules = [
        ./tp-x280/home-manager.nix
      ];
      overlays = [
        inputs.rust-overlay.overlays.default
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
    "ms0503@test" = mkHomeManagerConfiguration {
      modules = [
        ./test/home-manager.nix
      ];
      overlays = [
        inputs.rust-overlay.overlays.default
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
  };
  nixos = {
    rtex = mkNixosSystem {
      hostname = "rtex";
      modules = [
        ./rtex/nixos.nix
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
    test = mkNixosSystem {
      hostname = "test";
      modules = [
        ./test/nixos.nix
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
  };
}
