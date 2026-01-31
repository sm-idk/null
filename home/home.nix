{
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  imports = [ inputs.self.homeModules ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      onlyoffice-desktopeditors
      transmission_4-qt
      signal-desktop
      bottles
      ghostty
      equibop
      btop

      prismlauncher
      yt-dlp
      mpv
      gnome-frog
      ;
    inherit (pkgsUnstable)
      rpcs3
      equicord
      ;
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  # The version should stay at the version you originally installed.
  home.stateVersion = "25.05";
}
