_:{
  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    environment = {
      "TORRENTING_PORT" = "52719";
      "WEBUI_PORT" = "8080";
    };
    volumes = [
      "/var/lib/containers/qbittorrent/config:/config:rw"
      "/data:/data:rw"
      "/home/rikka/Downloads:/downloads:rw"
    ];
    user = "1000:100";
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
}
