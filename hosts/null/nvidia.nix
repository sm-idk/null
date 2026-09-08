{
  config,
  lib,
  pkgs,
  ...
}:
let
  # linuxPackages_cachyos builds with CONFIG_MODULE_COMPRESS_ZSTD, so
  # modules_install emits .ko.zst that stdenv's `strip -S` fixup cannot strip;
  # the leftover DWARF paths referencing the kernel's dev output then violate
  # the derivation's `allowedReferences = [ ]`. Stripping during
  # modules_install (before compression) removes them.
  stripModules =
    modDrv:
    let
      upstreamMakeFlags =
        (modDrv.overrideAttrs (old: {
          passthru = (old.passthru or { }) // { makeFlags = old.makeFlags or [ ]; };
        })).passthru.makeFlags;
      fixedUpstream = builtins.any (flag: lib.hasPrefix "INSTALL_MOD_STRIP" (toString flag)) upstreamMakeFlags;
    in
    lib.warnIf fixedUpstream ''
      nvidia kernel modules strip themselves upstream now; the INSTALL_MOD_STRIP
      workaround in hosts/null/nvidia.nix can be removed.
    ''
    (
      if fixedUpstream then
        modDrv
      else
        modDrv.overrideAttrs (old: {
          makeFlags = old.makeFlags ++ [ "INSTALL_MOD_STRIP=1" ];
        })
    );
in
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;

    package = pkgs.nvidia_cachyos // {
      mod = stripModules pkgs.nvidia_cachyos.mod;
      open = lib.mapNullable stripModules pkgs.nvidia_cachyos.open;
    };
  };

  environment.sessionVariables = {
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) zenith-nvidia;
    inherit (pkgs.nvtopPackages) full;
  };
}
