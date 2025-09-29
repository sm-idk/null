{
  config,
  pkgs,
  stylix,
  ...
}:
{
  imports = [
    stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://wallpaperswide.com/download/red_desert_night_moon-wallpaper-1920x1080.jpg";
      hash = "sha256-kjeXb0ZLHjQefdqMy6+3YSQw94qypwgbuIwttrYoY/U=";
    };

    polarity = "dark";
    # polarity = "light";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/vesper.yaml";

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # iconTheme = {
    #   enable = true;
    #   dark = "MoreWaita";
    #   package = pkgs.morewaita-icon-theme;
    # };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    overlays.enable = false;

    targets = {
      gtk.extraCss = ''
        @define-color sidebar_bg_color #${config.lib.stylix.colors.base00};
        @define-color headerbar_bg_color #${config.lib.stylix.colors.base00};
      '';
      # zed.enable = false;
    };
  };
}
