{ lib, ... }: 

{
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = lib.mkDefault "/dev/vda";
      useOSProber = false;
    };
  };

  users.users.root = {
    initialHashedPassword = "$6$mHp1fCFK8PPE9eHi$3rvW1eABV7Jjd926gN46RMMobm68dJqRyRergwV94/.ItJwfMuOtTI2NAWtB4g5ORxtexxPARipSa5Zhwccgc0";
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJbU3Ry+vsDfPo3nkYi5MzO8dQ0LZu4yqtL3RoPYc3QZUhdISQIIpWsU12Dc+f0Vrdb0dgcoFZWE/NI+0NdKL4Q= rikka@rikka.im"
    ];
  };

  services.cloud-init = {
    enable = true;
    network.enable = true;
  };
  networking = {
    useNetworkd = true;
    useDHCP = false;
  };
  systemd.network.enable = true;
  services.resolved.enable = true;
  services.qemuGuest.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
  };

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}