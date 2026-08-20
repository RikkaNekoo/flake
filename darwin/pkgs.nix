{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    bat btop cyme fastfetch htop iperf3 ipmitool lsd nexttrace nmap 
    pv rsync tcping-go inetutils wget wireguard-tools macpm minicom
    mpremote android-tools

    autoconf autoconf-archive automake cmake gcc gnumake meson ninja pkgconf
    git hugo jadx nasm pipx rustup swift-format zig android-cli nixfmt nixd

    boost cairo dtc gmp lz4 xz librsvg libavif libraw libtool libusb1

    exiftool exiv2 ffmpeg imagemagick resvg

    gnupg libfido2 opensc openssh pcsclite pinentry_mac step-cli 
    yubikey-manager yubico-piv-tool

    gnutar p7zip

    (python3.withPackages (ps: with ps; [ tkinter ]))
    jdk17
    virt-manager
  ];
}
