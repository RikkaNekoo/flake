{ pkgs, ... }: 

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  glibc
  gcc.cc.lib
  zlib
];
}