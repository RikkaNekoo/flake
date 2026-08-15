_:{
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
}