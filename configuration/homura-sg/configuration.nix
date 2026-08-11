_: {

  imports = [
    ./hardware-configuration.nix
    ./containers.nix
    ../../nixos/roles/server.nix
    ../../nixos/filesystems/universal-xfs.nix
    ../../nixos/services/zram.nix
    ../../nixos/services/podman.nix
    ../../nixos/apps/ops.nix
    ../../nixos/apps/nix.nix
  ];

  networking.hostName = "Homura-SG";

  system.stateVersion = "26.05";
}