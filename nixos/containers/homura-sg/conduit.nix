_:{
  virtualisation.oci-containers.containers."conduit" = {
    image = "matrixconduit/matrix-conduit:latest";
    environmentFiles = [ "/var/lib/containers/conduit/conduit.env" ];
    environment = {
      "CONDUIT_SERVER_NAME" = "rikka.im";
      "CONDUIT_DATABASE_PATH" = "/var/lib/matrix-conduit/";
      "CONDUIT_DATABASE_BACKEND" = "rocksdb";
      "CONDUIT_PORT" = "80";
      "CONDUIT_MAX_REQUEST_SIZE" = "20000000";
      "CONDUIT_ALLOW_REGISTRATION" = "true";
      "CONDUIT_ALLOW_FEDERATION" = "true";
      "CONDUIT_ALLOW_CHECK_FOR_UPDATES" = "true";
      "CONDUIT_TRUSTED_SERVERS" = "[\"matrix.org\"]";
      "CONDUIT_ADDRESS" = "0.0.0.0";
      "CONDUIT_CONFIG" = "";
    };
    volumes = [
      "/var/lib/containers/conduit/data/db:/var/lib/matrix-conduit/:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };
}