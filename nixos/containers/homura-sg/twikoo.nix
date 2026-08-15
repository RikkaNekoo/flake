_:{
  virtualisation.oci-containers.containers."twikoo" = {
    image = "imaegoo/twikoo";
    environment = {
      "TWIKOO_THROTTLE" = "1000";
    };
    volumes = [
      "/var/lib/containers/twikoo/data:/app/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };
}