_:{
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
}