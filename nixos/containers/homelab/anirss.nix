_:{
  virtualisation.oci-containers.containers."ani-rss" = {
    image = "wushuo894/ani-rss:latest";
    environment = {
      "PUID" = "1000";
      "PGID" = "100";
      "CONFIG" = "/config";
      "SERVER_PORT" = "7789";
      "TZ" = "Asia/Shanghai";
    };
    volumes = [
      "/var/lib/containers/ani-rss/config:/config:rw"
      "/data/Media:/data/Media:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
}