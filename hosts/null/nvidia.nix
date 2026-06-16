{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    moduleParams = {
      nvidia = {
        NVreg_UsePageAttributeTable = 1;
        NVreg_RegistryDwords = "RMUseSwI2c=0x01;RMI2cSpeed=100";
      };
    };

    # Temporary until at the very least https://github.com/NixOS/nixpkgs/pull/439793 merged
    # package = pkgs.nvidia-patch.patch-nvenc (
    #   pkgs.nvidia-patch.patch-fbc config.boot.kernelPackages.nvidiaPackages.beta\
    # );
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "580.82.09";
      sha256_64bit = "sha256-Puz4MtouFeDgmsNMKdLHoDgDGC+QRXh6NVysvltWlbc=";
      sha256_aarch64 = "sha256-6tHiAci9iDTKqKrDIjObeFdtrlEwjxOHJpHfX4GMEGQ=";
      openSha256 = "sha256-YB+mQD+oEDIIDa+e8KX1/qOlQvZMNKFrI5z3CoVKUjs=";
      settingsSha256 = "sha256-um53cr2Xo90VhZM1bM2CH4q9b/1W2YOqUcvXPV6uw2s=";
      persistencedSha256 = "sha256-lbYSa97aZ+k0CISoSxOMLyyMX//Zg2Raym6BC4COipU=";
    };
  };

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) zenith-nvidia;
    inherit (pkgs.nvtopPackages) full;
  };
}
