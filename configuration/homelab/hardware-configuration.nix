{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ 
    "kvm-intel" 
    # PCI passthrough support
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
  ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ ];
  boot.kernelParams = [
    "acpi_osi=!"
    ''acpi_osi="Windows 2020"''
    "intel_iommu=on"
    "iommu=pt"
  ];

  systemd.network.networks."90-wan" = {
    matchConfig.Name = "enp5s0d1";
    address = [ "10.21.0.99/24" ];
    gateway = [ "10.21.0.1" ];
    dns = [ "10.21.0.1" ];
  };

  swapDevices = [ { device = "/dev/disk/by-id/nvme-INTEL_MEMPEK1W016GA_PHBT721202K8016D-part2"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
