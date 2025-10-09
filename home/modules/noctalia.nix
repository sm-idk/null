{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  home.packages = [ inputs.noctalia.packages.${pkgs.system}.default ];

  programs.noctalia-shell.enable = true;
}
