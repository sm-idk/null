{ inputs, ... }:
{
  ledatel = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ./configuration.nix
      { nixpkgs.hostPlatform = "x86_64-linux"; }
    ];
  };
}
