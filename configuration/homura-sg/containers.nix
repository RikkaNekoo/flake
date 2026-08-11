_:{
  # Autodiscover
  virtualisation.oci-containers.containers."autodiscover" = {
    image = "monogramm/autodiscover-email-settings:latest";
    environment = {
      "COMPANY_NAME" = "RikkaMail";
      "SUPPORT_URL" = "https://mail.rikka.im";
      "DOMAIN" = "rikka.im";
      "IMAP_HOST" = "mail.rikka.im";
      "IMAP_PORT" = "993";
      "IMAP_SOCKET" = "SSL";
      "SMTP_HOST" = "mail.rikka.im";
      "SMTP_PORT" = "587";
      "SMTP_SOCKET" = "STARTTLS";
      "PROFILE_IDENTIFIER" = "im.rikka.autodiscover";
      "PROFILE_UUID" = "a1b62d77-92be-4586-9ef6-290555c8f7e2";
      "MAIL_UUID" = "2298f4dc-10dd-4078-af1b-ac75a26e09a7";
      "LDAP_UUID" = "b0d3cde7-bfde-4281-bffc-cad0d723a337";
    };
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };

  # Caddy
  virtualisation.oci-containers.containers."caddy" = {
    image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
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
    extraOptions = [
      "--network=rikka"
    ];
  };

  # Conduit
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

  # Mailserver
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

  # PostgreSQL
  virtualisation.oci-containers.containers."pgsql" = {
    image = "postgres:17";
    environment = {
      "TZ" = "Asia/Shanghai";
      "POSTGRES_DB" = "postgres";
    };
    environmentFiles = [ "/var/lib/containers/pgsql/pgsql.env" ];
    ports = [
      "58200:5432"
    ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/lib/containers/pgsql/data:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };

  # Roundcube
  virtualisation.oci-containers.containers."roundcube" = {
    image = "roundcube/roundcubemail:latest";
    environmentFiles = [ "/var/lib/containers/roundcube/roundcube.env" ];
    environment = {
      "ROUNDCUBEMAIL_DB_TYPE" = "pgsql";
      "ROUNDCUBEMAIL_DB_HOST" = "pgsql";
      "ROUNDCUBEMAIL_SKIN" = "elastic";
      "ROUNDCUBEMAIL_DEFAULT_HOST" = "tls://mail.rikka.im";
      "ROUNDCUBEMAIL_SMTP_SERVER" = "tls://mail.rikka.im";
    };
    volumes = [
      "/var/lib/containers/roundcube/www:/var/www/html:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };

  # Twikoo
  virtualisation.oci-containers.containers."twikoo" = {
    image = "imaegoo/twikoo";
    environment = {
      "TWIKOO_THROTTLE" = "1000";
    };
    volumes = [
      "/var/lib/containers/twikoo/data:/app/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };

  # Umami
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

  # Vaultwarden
  virtualisation.oci-containers.containers."vaultwarden" = {
    image = "vaultwarden/server:latest";
    environmentFiles = [ "/var/lib/containers/vaultwarden/vaultwarden.env" ];
    volumes = [
      "/var/lib/containers/vaultwarden/data:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };
}
