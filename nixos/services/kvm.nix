_: {
  virtualisation.libvirtd.enable = true;

  users.users.rikka.extraGroups = [
    "libvirtd"
    "kvm"
  ];
}