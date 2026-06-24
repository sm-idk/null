{ inputs, ... }:
{
  imports = [ inputs.self.nixosModules.default ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  services.displayManager.gdm.enable = true;

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
    ];
  };

  services.printing.enable = true;

  # Enable nix-ld for LSP servers downloaded by Zed
  programs.nix-ld.enable = true;

}
