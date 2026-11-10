{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.stylix.nixosModules.stylix
    inputs.bootvine.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bruno = ../../home/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };

  services.bootvine.enable = true;

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  services.desktopManager.gnome.enable = true;

  home-manager.backupFileExtension = "bak";

  # User
  users.users.bruno = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$mvJlLXGvrwdfLcPVpgL2V.$tGJiUax1vrFDtDhtljQ.q749KII4oUnx0dJph3zJCj1";
    description = "Bruno";
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
      "seat"
      "lp"
    ];
  };

  services.printing.enable = true;
  services.avahi.enable = true;

  # Enable nix-ld for LSP servers downloaded by Zed
  programs.nix-ld.enable = true;

}
