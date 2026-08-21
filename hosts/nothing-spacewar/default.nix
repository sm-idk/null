{ inputs, ... }:

inputs.nixos-mobile.lib.nixosMobileSystems "nothing-spacewar" {
  specialArgs = { inherit inputs; };
  modules = [ ./configuration.nix ];
}
