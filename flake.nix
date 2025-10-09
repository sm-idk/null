{
  description = "A multi‑system flake that pulls in the listed third‑party flakes";

  inputs = {
    # First‑party (official)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home‑manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Second‑party (unofficial)
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Third‑party custom flakes
    niri = {
      url = "github:sodiboo/niri-flake";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      niri,
      chaotic,
      vicinae,
      spicetify-nix,
      nur,
      noctalia,
      nix-flatpak,
      zen-browser,
      ...
    }@inputs:

    let
      pkgsUnstable = (
        { config, ... }:
        {
          _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            config = config.nixpkgs.config;
          };
        }
      );

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.bruno = ./home/home.nix;
        extraSpecialArgs = {
          inherit
            niri
            stylix
            vicinae
            spicetify-nix
            chaotic
            nur
            noctalia
            zen-browser
            ;
        };
      };

      nixosModules = [
        inputs.home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix

        niri.nixosModules.niri

        nur.modules.nixos.default

        chaotic.nixosModules.nyx-cache
        chaotic.nixosModules.nyx-overlay
        chaotic.nixosModules.nyx-registry

        nix-flatpak.nixosModules.nix-flatpak
      ];
    in

    {
      nixosModules = import ./modules/core;
      homeModules = import ./home/modules;
      nixosConfigurations = {
        null = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/null/configuration.nix
            pkgsUnstable
            home-manager
          ]
          ++ nixosModules;
        };

        ledatel = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/ledatel/configuration.nix
            pkgsUnstable
            home-manager
          ]
          ++ nixosModules;
        };
      };
    };
}
