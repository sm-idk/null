{ inputs, lib, ... }:
{
  imports = [
    ../common

    ./hardware-configuration.nix
    ./hardware-asahi.nix
    # ./overlays.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.stylix.nixosModules.stylix
    inputs.apple-silicon.nixosModules.apple-silicon-support
    # inputs.steam-asahi.nixosModules.default
  ];

  # programs.steam-asahi.enable = true;
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  programs.kdeconnect.enable = true;

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

  # Asahi/Apple Silicon systems commonly use 16K pages, where the NixOS
  # default of 33 ASLR bits is invalid. 31 is the maximum for this layout.
  boot.kernel.sysctl."vm.mmap_rnd_bits" = lib.mkForce 31;

  # Specify path to peripheral firmware files for declarative management
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Build the heavy Asahi packages (kernel, u-boot, m1n1, asahi-fwextract)
  # against the exact nixpkgs revision used by nixos-apple-silicon CI, so their
  # Cachix paths match. Using our own nixpkgs/nixpkgs-unstable rev changes the
  # derivation hash and forces a local kernel build.
  hardware.asahi.pkgs = lib.mkForce (
    import inputs.apple-silicon.inputs.nixpkgs {
      localSystem.system = "aarch64-linux";
      config.allowUnfree = true;
      overlays = [ inputs.apple-silicon.overlays.apple-silicon-overlay ];
    }
  );

  nixpkgs.config.allowUnsupportedSystem = true;

  services.power-profiles-daemon.enable = false;

  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 70;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  # System services
  services.fstrim.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.11";
}
