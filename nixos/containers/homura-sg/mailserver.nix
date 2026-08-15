_:{
  virtualisation.oci-containers.containers."mailserver" = {
    image = "ghcr.io/docker-mailserver/docker-mailserver:latest";
    hostname = "mail.rikka.im";
    environmentFiles = [ "/var/lib/containers/mailserver/mailserver.env" ];
    ports = [
      "25:25"
      "143:143"
      "465:465"
      "587:587"
      "993:993"
    ];
    volumes = [
      "/var/lib/containers/caddy/data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/wildcard_.rikka.im:/var/certs"
      "/var/lib/containers/mailserver/data/mail-data:/var/mail/:rw"
      "/var/lib/containers/mailserver/data/mail-state:/var/mail-state/:rw"
      "/var/lib/containers/mailserver/data/mail-logs:/var/log/mail/:rw"
      "/var/lib/containers/mailserver/data/config:/tmp/docker-mailserver/:rw"
      "/etc/localtime:/etc/localtime:ro"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--stop-timeout=60"
      "--health-cmd=ss --listening --tcp | grep -P 'LISTEN.+:smtp' || exit 1"
      "--health-timeout=3s"
      "--health-retries=1"
      "--network=rikka"
    ];
  };
}