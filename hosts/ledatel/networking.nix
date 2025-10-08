{
  pkgsUnstable,
  ...
}:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    package = pkgsUnstable.tailscale;
  };

  programs.mtr.enable = true;

  networking.networkmanager.enable = true;
}
