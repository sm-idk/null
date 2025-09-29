_: {
  # Nix settings
  nix = {
    optimise.automatic = true;
    channel.enable = false;
    settings = {
      experimental-features = "nix-command flakes";
      substituters = [ "https://nix-community.cachix.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];

      auto-optimise-store = true;
    };
    # Make builds run with low priority so system stays responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.overlays = [ nur.overlays.default ];

  # Faster dbus implementation
  services.dbus.implementation = "broker";

  # Disable built-in NixOS documentation
  documentation.nixos.enable = false;
}
