_:{
  virtualisation.oci-containers.containers."ani-rss" = {
    image = "wushuo894/ani-rss:latest";
    user = "1000:100";
    environment = {
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
      # This fix "chown: /usr/app: Operation not permitted"
      "--cap-add=CHOWN"
      "--cap-add=SETUID"
      "--cap-add=SETGID"
    ];
  };
}
