{ inputs, ... }:
{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  services.vicinae = {
    enable = true;
    systemd.autoStart = true;

    settings = {
      faviconService = "twenty";
      font.size = 11;
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      # theme.name = "vicinae-dark";
      window = {
        # csd = true;
        # opacity = 0.85;
        rounding = 10;
      };
    };
  };
}
