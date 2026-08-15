_: {
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
}
