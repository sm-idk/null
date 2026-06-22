_: {
  services.pipewire = {
    alsa.enable = true;
    jack.enable = true;
  };

  # Audio-related security settings
  security.rtkit.enable = true;
}
