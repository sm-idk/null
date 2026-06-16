{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./networking.nix
    inputs.self.nixosModules.default
  ];

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

  # services.displayManager.ly.enable = true;
  # services.displayManager.gdm.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = true;
  # services.desktopManager.gnome.enable = true;
  # services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.xwayland.enable = true;

  home-manager.backupFileExtension = "bak";

  # Hardware / desktop integration for Noctalia
  hardware.bluetooth.enable = true;
  powerManagement.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = lib.mkDefault true;
  programs.kdeconnect.enable = true;

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

  programs.niri = {
    enable = true;
    # Use nixpkgs' niri so we can substitute from cache.nixos.org on all hosts
    # (notably aarch64/zero). niri-flake's own Cachix is x86_64-only, so its
    # default package makes zero build niri locally.
    package = pkgs.niri;
  };

  # Enable Wireshark with USB support
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark; # otherwise you get the CLI version
    usbmon.enable = true; # enable USB capture
    dumpcap.enable = true; # enable network capture
  };
  # Add your user account to the Wireshark group
  users.groups.wireshark.members = [ "bruno" ];

  services.printing.enable = true;

  # Enable nix-ld for LSP servers downloaded by Zed
  programs.nix-ld.enable = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
