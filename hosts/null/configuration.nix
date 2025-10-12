{ inputs, pkgsUnstable, ... }:
{
  imports = [
    ../common/configuration.nix

    ./hardware.nix
    ./hardware-configuration.nix

    inputs.self.nixosModules

    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.nur.modules.nixos.default
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
