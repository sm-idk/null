{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  helium = inputs.euvlok-pkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.helium-browser;
in
{
  imports = [ ./extension-install.nix ];

  home.packages = [ helium ];

  xdg.dataFile."applications/helium-browser.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Helium
    GenericName=Web Browser
    Comment=Browse the web
    Exec=${lib.getExe helium} %U
    Icon=helium-browser
    Terminal=false
    Categories=Network;WebBrowser;
    MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
    StartupNotify=true
    StartupWMClass=helium-browser
  '';

  # Uncomment if you want Helium to become the default browser.
  # xdg.mimeApps.defaultApplications = lib.genAttrs [
  #   "text/html"
  #   "text/xml"
  #   "application/xhtml+xml"
  #   "x-scheme-handler/http"
  #   "x-scheme-handler/https"
  # ] (_: "helium-browser.desktop");
}
