{ pkgs, inputs, lib, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
      # Disable the built-in flake registry to speed up evaluation
      flake-registry = "";
      trusted-users = [
        "@wheel"
        "root"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;

    # This is important. It locks nixpkgs registry used in nix shell
    # to the same of flakes. Saves time.
    registry =
        {
          pkgs.flake = inputs.self;
        }
        // lib.mapAttrs (_: flakes: {flake = flakes;}) inputs;

      channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  hardware.enableRedistributableFirmware = true;
}