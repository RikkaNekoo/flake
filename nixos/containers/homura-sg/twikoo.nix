_:{
  virtualisation.oci-containers.containers."twikoo" = {
    image = "imaegoo/twikoo";
    networks = [ "rikka" ];
    environment = {
      "TWIKOO_THROTTLE" = "1000";
    };
    volumes = [
      "/var/lib/containers/twikoo/data:/app/data:rw"
    ];
    log-driver = "journald";
  };
}
