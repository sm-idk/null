{ inputs, pkgsUnstable, ... }:
{
  imports = [
    ../common/configuration.nix

    ./hardware-acceleration.nix
    ./hardware-configuration.nix

    inputs.self.nixosModules

    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.nur.modules.nixos.default
    inputs.stylix.nixosModules.stylix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bruno = ../../home/home.nix;
    extraSpecialArgs = { inherit inputs pkgsUnstable; };
  };

  networking.hostName = "ledatel";

  programs = {
    virt-manager.enable = true;
    nh.enable = true;
    niri.enable = true;
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };
  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;

  # System services (tailscale is configured in mandatory modules)
  services = {
    printing.enable = true;
    kismet.httpd.enable = true;
    scx.enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.05";
}
