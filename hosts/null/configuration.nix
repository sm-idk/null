_: {
  imports = [
    ./hardware.nix
    ./hardware-configuration.nix

    ../../modules/core/steam.nix
  ];

  networking.hostName = "null";

  # Hardware
  hardware = {
    uinput.enable = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.05";
}
