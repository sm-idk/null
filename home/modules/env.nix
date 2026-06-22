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
  home.sessionVariables = {
    BROWSER = lib.getExe helium;
    VISUAL = lib.getExe pkgs.unstable.zed-editor;
  };
}
