{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.self.homeModules.default ];

  home.packages = builtins.attrValues {

    inherit (pkgs)
      btop
      ghostty
      file
      ;

    octave = pkgs.octaveFull.withPackages (p: [ p.symbolic ]);

    inherit (pkgs.unstable)
      onlyoffice-desktopeditors
      signal-desktop
      bottles
      prismlauncher
      yt-dlp
      gnome-frog
      rpcs3
      ;
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  # The version should stay at the version you originally installed.
  home.stateVersion = "25.05";
}
