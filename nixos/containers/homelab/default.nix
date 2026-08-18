_:{
  imports = [
    ./anirss.nix
    ./caddy.nix
    ./frpc.nix
    ./jellyfin.nix
    ./qbit.nix
  ];

  # So that I can use podman without sudo
  users.users.rikka.extraGroups = [ "podman" ];
  environment.sessionVariables = {
    CONTAINER_HOST = "unix:///run/podman/podman.sock";
  };
}
