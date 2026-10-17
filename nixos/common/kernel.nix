# Temporarily switch to xanmod, see flake.nix
{ pkgs, inputs, ... }: 

{
  # nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
}
