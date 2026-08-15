_:{
  virtualisation.oci-containers.containers."umami" = {
    image = "ghcr.io/umami-software/umami:postgresql-latest";
    environmentFiles = [ "/var/lib/containers/umami/umami.env" ];
    log-driver = "journald";
    extraOptions = [
      "--init"
      "--health-cmd=curl http://localhost:3000/api/heartbeat"
      "--health-interval=5s"
      "--health-timeout=5s"
      "--health-retries=5"
      "--network=rikka"
    ];
  };
}