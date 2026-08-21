{ pkgs, ... }:
{
  imports = [
    ../../home/modules/git.nix
    ../../home/modules/helium
    ../../home/modules/keepassxc.nix
    ../../home/modules/stylix.nix
  ];

  home.packages = [
    pkgs.btop
    pkgs.file
    pkgs.unstable.yt-dlp
  ];

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
