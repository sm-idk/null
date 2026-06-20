{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;

    # Use Equibop (native ARM64 Discord client)
    equibop.enable = true;
    equibop.package = pkgs.unstable.equibop;

    # Disable official Discord (not available on aarch64)
    discord.enable = false;

    config = {
      frameless = false;
      autoUpdateNotification = true;

      plugins = {
        webpackTarball = {
          enable = true;
          patched = true;
        };
        equicordHelper = {
          enable = true;
        };
        saveFavoriteGifs.enable = true;
        betterCommands = {
          enable = true;
          autoFillArguments = true;
          allowNewlinesInCommands = true;
        };
        ghosted = {
          enable = true;
          showDmIcons = true;
        };
        newPluginsManager.enable = true;
        noNitroUpsell.enable = true;
        equicordToolbox.enable = true;

        disableDeepLinks.enable = true;
        webContextMenus.enable = true;
        alwaysTrust = {
          enable = true;
          domain = true;
          file = true;
          noDeleteSafety = true;
        };
        betterSettings = {
          enable = true;
          disableFade = true;
          eagerLoad = true;
          organizeMenu = true;
        };
        clearUrls.enable = true;
        consoleJanitor = {
          enable = true;
          disableSpotifyLogger = true;
          whitelistedLoggers = "GatewaySocket; Routing/Utils";
        };
        crashHandler.enable = true;
        dearrow = {
          enable = true;
          replaceElements = 0;
          dearrowByDefault = true;
        };
        fakeNitro = {
          enable = true;
          enableStickerBypass = true;
          enableStreamQualityBypass = true;
          enableEmojiBypass = true;
          transformEmojis = true;
          transformStickers = true;
          stickerSize = 160.0;
          hyperLinkText = "{{NAME}}";
          useStickerHyperLinks = true;
        };
        favoriteGifSearch = {
          enable = true;
          searchOption = "hostandpath";
        };
        noTypingAnimation.enable = true;
        platformIndicators = {
          enable = true;
          colorMobileIndicator = true;
          list = true;
          profiles = true;
          messages = true;
          consoleIcon = "equicord";
        };
        relationshipNotifier = {
          enable = true;
          offlineRemovals = true;
          groups = true;
          servers = true;
          friends = true;
          friendRequestCancels = true;
        };
        replaceGoogleSearch = {
          enable = true;
          customEngineUrl = "https://duckduckgo.com/?=";
        };
        spotifyCrack = {
          enable = true;
          noSpotifyAutoPause = true;
        };
        webKeybinds.enable = true;
        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;
        betterGifLoad = {
          enable = true;
          gifQuality = 2;
        };
      };
    };
  };

  # Ensure desktop entries are available
  xdg.dataFile = {
    "applications/equibop.desktop".text = ''
      [Desktop Entry]
      Categories=Network;InstantMessaging;Chat
      Exec=equibop %U
      GenericName=Internet Messenger
      Icon=equibop
      Keywords=discord;equibop;electron;chat
      Name=Equibop
      StartupWMClass=Equibop
      Type=Application
      Version=1.5
    '';
  };
}
