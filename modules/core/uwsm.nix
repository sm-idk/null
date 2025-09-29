_: {
  programs = {
    uwsm.enable = true;
    uwsm.waylandCompositors = {
      niri = {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };
}
