{
  inputs,
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

  nixpkgs.overlays = [
    (import ./overlays.nix)
  ]
  ++ [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (prev.stdenvNoCC.hostPlatform) system;
        overlays = (prev.overlays or [ ]);
        config = {
          allowUnsupportedSystem = true;
        };
      };
    })
  ];

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

  nixpkgs.config.allowUnsupportedSystem = true;

  environment.systemPackages = with pkgs.unstable; [
    distrobox
    muvm
    xorg.xhost

    asahi-audio
    asahi-bless
    asahi-fwextract
    squashfuse
    squashfsTools
    erofs-utils
    m1n1
  ];

  # Podman for distrobox containers
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

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
  services.fstrim.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.11";
}
