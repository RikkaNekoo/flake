_: {

  imports = [
    ../../nixos/containers/homura-sg
    ./hardware-configuration.nix
    ../../nixos/roles/server.nix
    ../../nixos/filesystems/universal-xfs.nix
    ../../nixos/services/zram.nix
    ../../nixos/services/podman.nix
    ../../nixos/apps/ops.nix
    ../../nixos/apps/nix.nix
  ];

  networking.hostName = "Homura-SG";

  services.vscode-server.enable = true;

  system.stateVersion = "26.05";
}
