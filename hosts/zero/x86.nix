{ inputs, ... }:
let
  pkgs-x86 = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = [
    pkgs-x86.steam
    pkgs-x86.steam-run
    pkgs-x86.vulkan-tools
    pkgs-x86.glmark2
    pkgs-x86.mesa-demos
    pkgs-x86.virglrenderer
  ];
}
