{
  description = " A very bad attempt at making a nice personal NixOS config ";

  inputs = {
    # First‑party (official)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home‑manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Third‑party custom flakes
    nixos-mobile.url = "git+https://codeberg.org/Whoman/nixos-mobile.git";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    niri = {
      url = "github:sodiboo/niri-flake";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    euvlok-pkgs.url = "github:euvlok/pkgs";

    # apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    # Keep this pinned: Apple Silicon updates can replace the shared m1n1 boot.bin.
    apple-silicon.url = "github:nix-community/nixos-apple-silicon/3902c801519264191a7c3dfec8dd1f9faeb38fd5";

    steam-asahi = {
      # Use the local checkout while developing and testing changes.
      # url = "path:/home/bruno/git/steam-asahi";
      url = "github:sm-idk/steam-asahi/feature/arm64-client";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosModules.default = import ./modules/core;
    homeModules.default = import ./home/modules;
    nixosConfigurations = import ./hosts { inherit inputs; };
  };
}
