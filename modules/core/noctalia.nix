{ inputs, ... }:
{
  imports = [ inputs.noctalia.nixosModules.default ];

  programs.noctalia.recommendedServices.enable = true;
  # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
}
