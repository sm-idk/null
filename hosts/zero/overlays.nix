final: prev: {
  libkrunfw = prev.libkrunfw.overrideAttrs (oldAttrs: rec {
    version = "5.2.0";

    src = prev.fetchFromGitHub {
      owner = "containers";
      repo = "libkrunfw";
      tag = "v${version}";
      hash = "sha256-aX4AGjXba6bhOIbP9OSHGiRXzYZpHaZ9fVwJD0iT4ww=";
    };

    kernelSrc = prev.fetchurl {
      url = "mirror://kernel/linux/kernel/v6.x/linux-6.12.68.tar.xz";
      hash = "sha256-02fHUEvU2lIN0B6wgSXS0KwIi8ivTNVtI28gdN1CJbc=";
    };
  });

  libkrun = prev.libkrun.overrideAttrs (oldAttrs: rec {
    version = "1.17.4";

    src = prev.fetchFromGitHub {
      owner = "containers";
      repo = "libkrun";
      tag = "v${version}";
      hash = "sha256-Th4vCg3xHb6lbo26IDZES7tLOUAJTebQK2+h3xSYX7U=";
    };

    cargoDeps = prev.rustPlatform.importCargoLock {
      lockFile = src + "/Cargo.lock";
    };

    buildInputs = oldAttrs.buildInputs ++ [ prev.libcap_ng ];
  });
  muvm = prev.muvm.overrideAttrs (oldAttrs: rec {
    version = "0.5.1";

    src = prev.fetchFromGitHub {
      owner = "AsahiLinux";
      repo = "muvm";
      tag = "muvm-${version}";
      hash = "sha256-eXsU2QRJ55gx5RhjT+m9F1KAFqGrd4WwnyR3eMpuIc4=";
    };

    cargoDeps = prev.rustPlatform.importCargoLock {
      lockFile = src + "/Cargo.lock";
    };
  });
}
