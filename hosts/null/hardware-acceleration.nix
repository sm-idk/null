# Hardware acceleration configuration for null (NVIDIA)
# Provides the Vulkan/GL loader stack + 32-bit support required by Steam/Proton.
{
  lib,
  pkgs,
  config,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      # Vulkan loader: binds the installed nvidia_icd.json so apps can find the GPU.
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer

      # VA-API on NVIDIA (matches LIBVA_DRIVER_NAME = "nvidia" in nvidia.nix)
      nvidia-vaapi-driver
      libva
      libva-utils
    ];
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) vulkan-tools mesa-demos;
  };
}
