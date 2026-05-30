{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./zfs-pool.nix
    ./containers.nix
    ./qbit-dscp.nix
    ../../nixos/filesystems/efi-with-btrfs.nix
    ../../nixos/services/zram.nix
    ../../nixos/apps/ops.nix
    ../../nixos/apps/nix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;

  networking.hostName = "Rikka-HomeLab";
  networking.useNetworkd = true;
  services.resolved.enable = true;
  networking.firewall.enable = false;

  users.users.rikka = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJbU3Ry+vsDfPo3nkYi5MzO8dQ0LZu4yqtL3RoPYc3QZUhdISQIIpWsU12Dc+f0Vrdb0dgcoFZWE/NI+0NdKL4Q= rikka@rikka.im"
    ];
  };

  services.openssh.enable = true;
  services.vscode-server.enable = true;

  system.stateVersion = "25.11";
}

