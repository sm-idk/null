_: {
  imports = [
    ./networking.nix
    ./hardware-acceleration.nix
    ./hardware-configuration.nix

    ../../modules/core/audio.nix
    ../../modules/core/mandatory.nix
    ../../modules/core/nix.nix
    # ../../modules/core/steam.nix
    ../../modules/core/uwsm.nix
  ];

  networking.hostName = "ledatel";

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

  # Hardware
  hardware = {
    bluetooth.enable = true;
  };
  powerManagement.enable = true;

  # User
  users.mutableUsers = true;
  users.users.bruno = {
    isNormalUser = true;
    initialPassword = "Ledatel1234";
    password = "$y$j9T$WM/haleJarxktY.wzlQHJ/$mm2XunJfQL.ZlOQij6TzMcDDOmMCnIvBacJnnimySC/";
    description = "Bruno";
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
      "seat"
    ];
  };

  programs = {
    virt-manager.enable = true;
    nh.enable = true;
    niri.enable = true;
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };

  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;

  # System services (tailscale is configured in mandatory modules)
  services = {
    printing.enable = true;
    kismet.httpd.enable = true;
    gnome.gnome-keyring.enable = true;
    colord.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    scx.enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.05";
}
