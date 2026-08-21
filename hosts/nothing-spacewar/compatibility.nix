{ lib, ... }:
{
  disabledModules = [
    ../../modules/core/niri.nix
    ../../modules/core/noctalia.nix
    ../../modules/core/virtualisation.nix
    ../../modules/core/wireshark.nix
  ];

  # The shared host profile assumes an EFI workstation. The phone uses the
  # Android boot flow supplied by nixos-mobile and should rely on zram instead
  # of creating the common 16 GiB swap file on flash storage.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  swapDevices = lib.mkForce [ ];

  # Phosh owns tty1 directly, so do not start the workstation display manager
  # or GNOME session alongside it.
  services.displayManager.gdm.enable = lib.mkForce false;
  services.desktopManager.gnome.enable = lib.mkForce false;

  # The firewall is currently broken for this nixos-mobile device profile.
  networking.firewall.enable = false;

  # These workstation discovery and printing services are not needed on the
  # phone and otherwise retain CUPS and related packages in the closure.
  services.avahi.enable = lib.mkForce false;
  services.printing.enable = lib.mkForce false;
}
