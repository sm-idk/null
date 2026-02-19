{ inputs, pkgs, ... }:
{
  imports = [
    ./networking.nix
    inputs.self.nixosModules.default
  ];

  boot = {
    binfmt.emulatedSystems = [ "x86_64-windows" ];
    supportedFilesystems = [ "ntfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_cachyos-lts;
    # kernelPackages = pkgs.linuxPackages_cachyos-gcc;
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
  # services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.xwayland.enable = true;

  services.scx.enable = true;

  home-manager.backupFileExtension = "bak";

  # Hardware
  hardware = {
    bluetooth.enable = true;
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

  programs.nh.enable = true;
  programs.niri.enable = true;

  # Enable nix-ld for LSP servers downloaded by Zed
  programs.nix-ld.enable = true;
}
