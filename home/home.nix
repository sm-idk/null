{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.self.homeModules.default ];

  home.packages = builtins.attrValues {

    inherit (pkgs)
      baobab
      btop
      decibels # Audio Player
      file
      ghostty
      loupe # Image Viewer
      nautilus
      pavucontrol
      showtime # Video Player
      system-config-printer
      virt-manager
      ;

    inherit (pkgs.unstable)
      onlyoffice-desktopeditors
      signal-desktop
      bottles
      prismlauncher
      rpcs3
      ;
  };

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  # The version should stay at the version you originally installed.
  home.stateVersion = "25.05";
}
