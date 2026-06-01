{ config, ... }: 

{
  # ZFS support
  boot.supportedFilesystems.zfs = true;
  boot.zfs.package = config.boot.kernelPackages.zfs_cachyos;
  networking.hostId = "40eeb16e";
  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly"; # Scrub can cause high temperatures so do it monthly
  };
  boot.zfs.forceImportRoot = false;

  # Import pool
  boot.zfs.devNodes = "/dev/disk/by-id";
  boot.zfs.extraPools = [ "data" ];

  # NFS server for sharing ZFS pool
  services.nfs.server.enable = true;
}