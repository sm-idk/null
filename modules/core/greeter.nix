{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  services.displayManager.noctalia-greeter = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;

    settings = {
      session.default = "niri";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
    };
  };
}
