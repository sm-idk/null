{ inputs, ... }: {
  imports = [
    inputs.chaotic.nixosModules.default
    ./audio.nix
    ./mandatory.nix
    ./niri.nix
    ./nix.nix
    ./noctalia.nix
    ./steam.nix
    ./virtualisation.nix
    ./wireshark.nix
  ];
}
