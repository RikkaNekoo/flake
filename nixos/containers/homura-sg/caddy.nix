_:{
  virtualisation.oci-containers.containers."caddy" = {
    image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
    networks = [ "rikka" ];
    ports = [
      "80:80"
      "443:443"
      "443:443/udp"
    ];
    volumes = [
      "/var/lib/containers/caddy/Caddyfile:/etc/caddy/Caddyfile:rw"
      "/var/lib/containers/caddy/srv:/srv:rw"
      "/var/lib/containers/caddy/data:/data:rw"
      "/var/lib/containers/caddy/config:/config:rw"
    ];
    log-driver = "journald";
  };
}
