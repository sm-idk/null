{ lib, ... }:
{
  # Hardware / desktop integration used by Noctalia widgets and plugins.
  hardware.bluetooth.enable = true;
  powerManagement.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = lib.mkDefault true;
  programs.kdeconnect.enable = true;
}
