{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  # Keep the pinned nixos-mobile input (and therefore its existing kernel
  # derivation), while replacing only the small stage0 userspace program.
  patchedStage0Init =
    inputs.nixos-mobile.packages.${config.mobile.localSystem}.stage0-init.overrideAttrs
      (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [ ./stage0-profiles.patch ];
      });
  statusBarLayout =
    (pkgs.formats.json { }).generate "status-bar-layout.json"
      config.mobile.stage0.statusBarLayout;
in
{
  imports = [
    ../common
    ./compatibility.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bruno = ./home.nix;
    extraSpecialArgs = { inherit inputs; };
  };

  mobile.devices.nothing-spacewar.enable = true;

  networking.hostName = "nothing-spacewar";

  services.openssh.enable = true;

  specialisation.stage0.configuration.boot.initrd.systemd = {
    storePaths = [ patchedStage0Init ];
    services.initrd-init.serviceConfig.ExecStart = lib.mkForce (
      "${lib.getExe patchedStage0Init} --status-bar-config ${statusBarLayout}"
    );
  };

  systemd.services.register-nix-paths = {
    description = "Register Nix Store Paths";
    unitConfig = {
      DefaultDependencies = false;
      ConditionPathExists = "/nix-path-registration";
    };
    wantedBy = [ "sysinit.target" ];
    before = [
      "sysinit.target"
      "shutdown.target"
      "nix-daemon.socket"
      "nix-daemon.service"
    ];
    after = [ "local-fs.target" ];
    conflicts = [ "shutdown.target" ];
    restartIfChanged = false;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${lib.getExe' config.nix.package.out "nix-store"} --load-db < /nix-path-registration
      rm /nix-path-registration
      ${lib.getExe' config.nix.package.out "nix-env"} \
        -p /nix/var/nix/profiles/system --set /run/current-system
    '';
  };

  users.users.bruno = {
    hashedPassword = lib.mkForce "$y$j9T$6OjzunII1.AXbg3oeCcaM/$yH4x1h3xn1OqdTFaCMWVfPsu05HQN3Ygj53YVUG7aC1";
    extraGroups = [ "audio" ];
  };

  services.xserver.desktopManager.phosh = {
    enable = true;
    user = "bruno";
    group = "users";
  };
  services.gnome = {
    gnome-keyring.enable = true;
    gnome-software.enable = true;
  };

  hardware.sensor.iio.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-console
    loupe
    nautilus
    phosh-mobile-settings
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.trusted-users = [
    "root"
    "bruno"
  ];

  system.stateVersion = "26.05";
}
