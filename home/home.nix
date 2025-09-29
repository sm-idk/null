{ pkgs, ... }:
{
  imports = [
    ./modules/chromium.nix
    ./modules/git.nix
    ./modules/keepassxc.nix
    ./modules/mako.nix
    ./modules/niri.nix
    ./modules/spicetify.nix
    ./modules/stylix.nix
    ./modules/vicinae.nix
    ./modules/waybar.nix
    ./modules/zed.nix
    ./modules/zen.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      onlyoffice-desktopeditors
      transmission_4-qt
      signal-desktop
      equicord
      bottles
      equibop
      rpcs3
      btop
      ;
  };

  programs.bash.enable = true;

  # The version should stay at the version you originally installed.
  home.stateVersion = "25.05";
}
