{
  config,
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.extraModprobeConfig =
    "options nvidia "
    + lib.concatStringsSep " " [
      # NVIDIA assumes that by default your CPU doesn't support `PAT`, but this
      # is effectively never the case in 2023
      "NVreg_UsePageAttributeTable=1"
      # This is sometimes needed for ddc/ci support, see
      # https://www.ddcutil.com/nvidia/
      #
      # Current monitor does not support it, but this is useful for
      # the future
      "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
    ];

  # Credit: https://github.com/NixOS/nixpkgs/issues/202454#issuecomment-1579609974
  environment.etc."egl/egl_external_platform.d".source =
    let
      nvidia_wayland = pkgs.writeText "10_nvidia_wayland.json" ''
        {
            "file_format_version" : "1.0.0",
            "ICD" : {
                "library_path" : "${pkgsUnstable.egl-wayland}/lib/libnvidia-egl-wayland.so"
            }
        }
      '';
      nvidia_gbm = pkgs.writeText "15_nvidia_gbm.json" ''
        {
            "file_format_version" : "1.0.0",
            "ICD" : {
                "library_path" : "${config.hardware.nvidia.package}/lib/libnvidia-egl-gbm.so.1"
            }
        }
      '';
    in
    lib.mkForce (
      pkgs.runCommandLocal "nvidia-egl-hack" { } ''
        mkdir -p "$out"
        cp ${nvidia_wayland} "$out/10_nvidia_wayland.json"
        cp ${nvidia_gbm} "$out/15_nvidia_gbm.json"
      ''
    );

  environment.sessionVariables = {
    # Required to run the correct GBM backend for NVIDIA GPUs on Wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this NOUVEAU may attempt to be used instead
    # (despite it being blacklisted)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  hardware.graphics = {
    extraPackages = builtins.attrValues {
      inherit (pkgs) libva-vdpau-driver libvdpau-va-gl nv-codec-headers-12;
    };
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) zenith-nvidia;
    inherit (pkgs.nvtopPackages) full;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
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
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };
}
