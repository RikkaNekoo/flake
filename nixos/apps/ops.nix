{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    lm_sensors
    smartmontools
    jq
  ];
}