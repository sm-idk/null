{
  pkgs,
  zen-browser,
  ...
}:
let
  default = {
    extensions.packages = builtins.attrValues {
      inherit (pkgs.nur.repos.rycee.firefox-addons)
        clearurls
        firemonkey
        refined-github
        sponsorblock
        ublock-origin
        ;
    };
    extensions.force = true;
    search = {
      force = true;
      default = "ddg";
      privateDefault = "ddg";
      order = [
        "Nix Packages"
        "GitHub"
        "youtube"
      ];
      engines = {
        "ddg" = {
          urls = [
            {
              template = "https://duckduckgo.com/";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://duckduckgo.com/favicon.ico";
          definedAliases = [ "@ddg" ];
        };
        "GitHub" = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://github.com/favicon.ico";
          definedAliases = [ "@gh" ];
        };
        "NixOS Wiki" = {
          urls = [
            {
              template = "https://nixos.wiki/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
        };
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Nix Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "type";
                  value = "options";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nq" ];
        };
        "Home Manager" = {
          urls = [
            {
              template = "https://home-manager-options.extranix.com";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "release";
                  value = "master";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
        "youtube" = {
          urls = [
            {
              template = "https://www.youtube.com/results";
              params = [
                {
                  name = "search_query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://youtube.com/favicon.ico";
          definedAliases = [ "@yt" ];
        };
      };
    };
    isDefault = true;
    settings = {
      "browser.urlbar.suggest.calculator" = true;
      "browser.urlbar.update2.engineAliasRefresh" = true;
    };
  };
  policies = {
    DisableAppUpdate = true;
    DisableTelemetry = true;
    OfferToSaveLogins = false;
    OfferToSaveLoginsDefault = false;
    PasswordManagerEnabled = false;
    NoDefaultBookmarks = true;
    DisableFirefoxAccounts = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisableMasterPasswordCreation = true;
    DisablePocket = true;
    DisableSetDesktopBackground = true;
  };
in
{
  imports = [ zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;
    profiles.default = default;
    inherit policies;
  };
}
