_: {
  virtualisation = {
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    containers = {
      registries.settings = {
        unqualified-search-registries = [ "docker.io" ];

        registry = [
          { location = "docker.io"; }
          { location = "quay.io"; }
        ];
      };
    };
  };
}
