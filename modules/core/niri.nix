{ lib, pkgs, ... }:
{
  programs.niri = {
    enable = true;
    # Use nixpkgs' niri so we can substitute from cache.nixos.org on all hosts
    # (notably aarch64/zero). niri-flake's own Cachix is x86_64-only, so its
    # default package makes zero build niri locally.
    package = pkgs.niri;
  };

  # niri-flake provides a polkit agent by default. Disable it so another agent
  # configured by the desktop shell can own authentication prompts.
  systemd.user.services.niri-flake-polkit.enable = lib.mkForce false;
}
