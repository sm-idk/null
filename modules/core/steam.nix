{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.nixos.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.nixos.steam.enable {
    hardware.steam-hardware.enable = true;

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      gamemode = {
        enable = true;
        enableRenice = true;
        settings.custom.start = "${lib.getExe pkgs.unstable.libnotify} 'GameMode started'";
        settings.custom.end = "${lib.getExe pkgs.unstable.libnotify} 'GameMode ended'";
      };
      gamescope.enable = true;
      gamescope.capSysNice = true;
    };
  };
}
