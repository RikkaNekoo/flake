_:{
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
}