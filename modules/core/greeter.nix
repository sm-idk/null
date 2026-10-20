{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  services.displayManager.noctalia-greeter = {
    enable = true;

    settings = {
      session.default = "niri";
      cursor = {
        path = pkgs.bibata-cursors;
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
    };
  };
}
