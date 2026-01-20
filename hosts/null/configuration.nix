{ inputs, pkgsUnstable, ... }:
{
  imports = [
    ../common/configuration.nix

    ./nvidia.nix
    ./hardware-configuration.nix

    inputs.self.nixosModules

    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.stylix.nixosModules.stylix
  ];

  nixos.steam.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bruno = ../../home/home.nix;
    extraSpecialArgs = { inherit inputs pkgsUnstable; };
  };

  networking.hostName = "null";

  # Hardware
  hardware = {
    uinput.enable = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.05";
}
