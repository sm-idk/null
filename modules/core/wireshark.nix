{
  # Capture support only. The graphical Wireshark app is installed via Home Manager.
  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    dumpcap.enable = true;
  };

  users.groups.wireshark.members = [ "bruno" ];
}
