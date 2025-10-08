{ noctalia, pkgs, ... }:
{
  imports = [
    noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    noctalia.packages.${system}.default
  ];

  programs.noctalia-shell = {
    enable = true;
  };
}
