{ pkgs, ... }:
{
  imports = [
    ../common

    ./nvidia.nix
    ./hardware-acceleration.nix
    ./hardware-configuration.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nixos.steam.enable = true;

  networking.hostName = "null";

  # Hardware
  hardware.uinput.enable = true;

  # NT sync primitives for Proton (PROTON_USE_NTSYNC=1)
  boot.kernelModules = [ "ntsync" ];

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.05";
}
