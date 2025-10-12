{
  inputs,
  pkgs,
  config,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  home.packages = [ inputs.noctalia.packages.${pkgs.system}.default ];

  programs = {
    noctalia-shell.enable = true;
    niri.settings.binds = with config.lib.niri.actions; {
      "Mod+L".action.spawn = noctalia "lockScreen toggle";
    };
  };
}
