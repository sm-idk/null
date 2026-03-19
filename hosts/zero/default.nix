{ inputs, ... }:
{
  zero = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    system = "aarch64-linux";
    modules = [
      ./configuration.nix

      {
        # nixpkgs.overlays = [
        #   (_: prev: {
        #     # Use nixos-muvm-fex packages
        #     mesa = inputs.nixos-muvm-fex.packages.aarch64-linux.mesa;
        #     muvm = inputs.nixos-muvm-fex.packages.aarch64-linux.muvm;
        #     fex = inputs.nixos-muvm-fex.packages.aarch64-linux.fex;
        #     fex-x86-rootfs = inputs.nixos-muvm-fex.packages.aarch64-linux.fex-x86-rootfs;
        #   })
        # ];
        nixpkgs.overlays = [ inputs.nixos-muvm-fex.overlays.default ];
      }
    ];
  };
}
