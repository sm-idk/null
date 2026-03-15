{
  inputs,
  pkgsUnstable,
  lib,
  ...
}:
{
  imports = [
    ../common

    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.stylix.nixosModules.stylix
    inputs.apple-silicon.nixosModules.apple-silicon-support
  ];

  boot.binfmt.emulatedSystems = [
    "x86_64-linux"
  ];

  # nixos.steam.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bruno = ../../home/home.nix;
    extraSpecialArgs = { inherit inputs pkgsUnstable; };
  };

  networking.hostName = "zero";

  # Apple Silicon specific configuration
  boot.loader.efi.canTouchEfiVariables = false;

  # Specify path to peripheral firmware files for declarative management
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Allow building aarch64 packages on x86_64
  nixpkgs.config.allowUnsupportedSystem = true;

  programs = {
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };

  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 70;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  # System services
  # services.scx.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.11";
}
