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
      btop
      ghostty
      ;

    inherit (pkgsUnstable)
      onlyoffice-desktopeditors
      transmission_4-qt
      signal-desktop
      bottles
      prismlauncher
      yt-dlp
      mpv
      gnome-frog
      rpcs3
      ;
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  # The version should stay at the version you originally installed.
  home.stateVersion = "25.05";
}
