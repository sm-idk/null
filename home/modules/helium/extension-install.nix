{ lib, pkgs, ... }:
let
  heliumConfigDir = "net.imput.helium";
  extensions = pkgs.callPackage ./extensions.nix { };

  extensionFile = ext: {
    name = "${heliumConfigDir}/External Extensions/${ext.id}.json";
    value = {
      force = true;
      text = builtins.toJSON (
        if (ext.crxPath or null) != null then
          {
            external_crx = "${ext.crxPath}";
            external_version = ext.version;
          }
        else
          {
            external_update_url = ext.updateUrl;
          }
      );
    };
  };
in
{
  xdg.configFile = lib.listToAttrs (map extensionFile extensions) // {
    "${heliumConfigDir}/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json" = {
      force = true;
      text = builtins.toJSON {
        name = "org.keepassxc.keepassxc_browser";
        description = "KeePassXC integration with native messaging support";
        path = "${pkgs.keepassxc}/bin/keepassxc-proxy";
        type = "stdio";
        allowed_origins = [
          "chrome-extension://oboonakemofpalcgghocfoadofidjkkk/"
        ];
      };
    };
  };
}
