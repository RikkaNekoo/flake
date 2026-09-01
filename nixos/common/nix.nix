_: {
  imports = [
    ../../common/nix.nix
  ];
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };

  hardware.enableRedistributableFirmware = true;
}
