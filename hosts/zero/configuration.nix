{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common

    ./hardware-configuration.nix
    ./hardware-asahi.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.stylix.nixosModules.stylix
    inputs.apple-silicon.nixosModules.apple-silicon-support
  ];

  # boot.binfmt.emulatedSystems = [
  #   "x86_64-linux"
  # ];

  # nixos.steam.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bruno = ../../home/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };

  networking.hostName = "zero";

  # Apple Silicon specific configuration
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelParams = [ "appledrm.show_notch=1" ];

  # Specify path to peripheral firmware files for declarative management
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Allow building aarch64 packCurrent RootFS path set to '/run/fex-emu/rootfs'
  nixpkgs.config.allowUnsupportedSystem = true;

  # nixos-muvm-fex packages for x86 emulation
  environment.systemPackages = with pkgs; [
    muvm
    fex
    fex-x86-rootfs

    asahi-audio
    asahi-bless
    asahi-fwextract
    squashfuse
    squashfsTools
    erofs-utils
    m1n1
  ];

  programs = {
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };

  services.power-profiles-daemon.enable = false;

  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 70;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  # System services
  # services.scx.enable = true;
  services.fstrim.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.11";
}
