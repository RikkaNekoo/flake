{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    btop
    pv
  ];
}