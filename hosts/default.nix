{ inputs, ... }:
{
  null = (import ./null { inherit inputs; }).null;
  laptop = (import ./laptop { inherit inputs; }).laptop;
  ledatel = (import ./ledatel { inherit inputs; }).ledatel;
  zero = (import ./zero { inherit inputs; }).zero;

  specialArgs = {
    inherit inputs;
    lib = inputs.nixpkgs.lib;
    pkgs-x86 = import inputs.nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };
      };
    };
  };
}
