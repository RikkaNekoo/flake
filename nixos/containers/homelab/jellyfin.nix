_:{
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "jellyfin/jellyfin:latest";
    environment = {
      "JELLYFIN_PublishedServerUrl" = "https://jellyfin.escatalor.izmn.link";
    };
    volumes = [
      "/var/lib/containers/jellyfin/cache:/cache:rw"
      "/var/lib/containers/jellyfin/config:/config:rw"
      "/data/Media:/data/Media:rw"
    ];
    user = "1000:100";
    log-driver = "journald";
    extraOptions = [
      "--add-host=host.docker.internal:host-gateway"
      "--network=host"
    ];
  };
}
