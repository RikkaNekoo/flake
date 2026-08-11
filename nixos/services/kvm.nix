_: {
  virtualisation.libvirtd.enable = true;

  systemd.services.libvirt-guests = {
    enable = true;

    serviceConfig = {
      Environment = [
        "ON_SHUTDOWN=shutdown"
        "ON_BOOT=ignore"
        "SHUTDOWN_TIMEOUT=300"
      ];
    };
  };

  users.users.rikka.extraGroups = [
    "libvirtd"
    "kvm"
  ];
}