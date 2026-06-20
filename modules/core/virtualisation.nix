{
  # The virt-manager GUI is installed via Home Manager.
  users.groups.libvirtd.members = [ "bruno" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
