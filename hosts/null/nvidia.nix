{
  pkgs,
  ...
}:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;

    package = pkgs.nvidia_cachyos;
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
