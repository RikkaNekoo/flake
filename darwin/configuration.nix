{ lib, pkgs, inputs, ... }:

{
  imports = [
    ./homebrew.nix
    ./pkgs.nix
    ../common/nix.nix
  ];

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 12;
      Minute = 0;
    };
    options = "--delete-older-than 7d";
  };

  services.tailscale.enable = true;
  programs.zsh.enable = true;

  system.primaryUser = "rikka";
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults = {
    dock.autohide = true;
    finder.ShowPathbar = true;
  };
  
  system.stateVersion = 7;
}