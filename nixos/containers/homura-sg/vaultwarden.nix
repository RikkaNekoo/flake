_:{
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