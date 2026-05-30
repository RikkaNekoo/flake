_:{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };
  virtualisation.oci-containers.backend = "podman";

  #Ani-RSS
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

  # Caddy
  virtualisation.oci-containers.containers."caddy" = {
    image = "cmunroe/caddy-dns:tencentcloud-latest";
    volumes = [
      "/var/lib/containers/caddy/Caddyfile:/etc/caddy/Caddyfile:rw"
      "/var/lib/containers/caddy/config:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };

  # Frpc
  virtualisation.oci-containers.containers."frpc" = {
    image = "snowdreamtech/frpc";
    volumes = [
      "/var/lib/containers/frp/frpc.toml:/etc/frp/frpc.toml:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };

  # Jellyfin
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

  # qBittorrent
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