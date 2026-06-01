{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ ];
  boot.kernelParams = [
    "acpi_osi=!"
    ''acpi_osi="Windows 2020"''
  ];

  systemd.network.networks."90-lan" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
  };

  swapDevices = [ { device = "/dev/disk/by-id/nvme-INTEL_MEMPEK1W016GA_PHBT721202K8016D-part2"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
