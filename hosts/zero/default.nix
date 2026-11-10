{ inputs, ... }:
{
  zero = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ./configuration.nix
      { nixpkgs.hostPlatform = "aarch64-linux"; }
    ];
  };
}
