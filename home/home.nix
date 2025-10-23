{ pkgs, inputs, ... }:
{
  imports = [ inputs.self.homeModules ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      onlyoffice-desktopeditors
      transmission_4-qt
      signal-desktop
      equicord
      bottles
      ghostty
      equibop
      rpcs3
      btop

      gnome-frog
      ;
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  # The version should stay at the version you originally installed.
  home.stateVersion = "25.05";
}
