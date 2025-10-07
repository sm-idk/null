{ pkgs, ... }:
{
  imports = [
    # "${nix-mineral}/nix-mineral.nix"
    ./networking.nix
    ./hardware.nix
    ./hardware-configuration.nix

    ../../modules/core/audio.nix
    ../../modules/core/mandatory.nix
    ../../modules/core/nix.nix
    ../../modules/core/steam.nix
    # ../../modules/core/uwsm.nix
  ];

  networking.hostName = "null";

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_cachyos-lts;
    # kernelPackages = pkgs.linuxPackages_cachyos-gcc;
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.scx.enable = true;

  # Hardware
  hardware = {
    bluetooth.enable = true;
    uinput.enable = true;
  };
  powerManagement.enable = true;

  # User
  users.mutableUsers = true;
  users.users.bruno = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$mvJlLXGvrwdfLcPVpgL2V.$tGJiUax1vrFDtDhtljQ.q749KII4oUnx0dJph3zJCj1";
    description = "Bruno";
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
      "seat"
    ];
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;

  programs.nh.enable = true;
  programs.niri.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.05";
}
