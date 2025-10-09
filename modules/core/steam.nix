{
  pkgsUnstable,
  lib,
  config,
  ...
}:
{
  options.nixos.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.nixos.steam.enable {
    hardware.steam-hardware.enable = true;
    nixpkgs.overlays = [
      (_: super: {
        steam = super.steam.override {
          extraPkgs =
            steamSuper:
            (builtins.attrValues {
              inherit (steamSuper)
                curl
                glxinfo
                imagemagick
                keyutils
                mangohud
                mesa-demos
                source-han-sans
                steamtinkerlaunch # just in case compattools doesn't works
                vkBasalt
                vulkan-validation-layers
                wqy_zenhei
                yad
                ;
              inherit (pkgsUnstable)
                libgdiplus
                libkrb5
                libpng
                libpulseaudio
                libvorbis
                ;
              inherit (pkgsUnstable)
                vulkan-caps-viewer
                vulkan-extension-layer
                vulkan-headers
                vulkan-tools
                ;
              inherit (steamSuper.xorg)
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
                xhost
                ;
              inherit (steamSuper.stdenv.cc.cc) lib;
            });
        };
        # for people that want non official bottles
        bottles = super.bottles.override { removeWarningPopup = true; };
      })
    ];

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        # https://github.com/NixOS/nixpkgs/blob/3730d8a308f94996a9ba7c7138ede69c1b9ac4ae/nixos/modules/programs/steam.nix#L12C3-L12C92
        # steam added a proper search for steamcompattools in your ~/.steam so variable should not be needed anymore
        # don't forget to periodically change steam's compatibility layer
        extraCompatPackages = builtins.attrValues {
          inherit (pkgsUnstable)
            # proton-ge-bin
            steamtinkerlaunch
            ;
        };
      };
      gamemode = {
        enable = true;
        enableRenice = true;
        settings.custom.start = "${lib.getExe pkgsUnstable.libnotify} 'GameMode started'";
        settings.custom.end = "${lib.getExe pkgsUnstable.libnotify} 'GameMode ended'";
      };
      gamescope.enable = true;
      gamescope.capSysNice = true;
    };
  };
}
