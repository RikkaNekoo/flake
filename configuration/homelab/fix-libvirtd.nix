{ pkgs, ... }:

{
  systemd.services.vfio-bind-05001 = {
    description = "Bind 0000:05:00.1 to vfio-pci";
    wantedBy = [ "multi-user.target" ];
    after = [ "sys-devices-pci0000:00-0000:00:03.0-0000:05:00.1-net-enp5s0v0.device" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "bind-vfio" ''
        DEV="0000:05:00.1"

        for i in $(seq 1 50); do
          if [ -e /sys/bus/pci/devices/$DEV ]; then
            break
          fi
          sleep 0.1
        done

        if [ -L /sys/bus/pci/devices/$DEV/driver ]; then
          echo $DEV > /sys/bus/pci/devices/$DEV/driver/unbind
        fi

        echo vfio-pci > /sys/bus/pci/devices/$DEV/driver_override

        echo $DEV > /sys/bus/pci/drivers/vfio-pci/bind
      '';
    };
  };

  systemd.services.libvirtd = {
    wants = [ "vfio-bind-05001.service" ];
    after = [ "vfio-bind-05001.service" ];
  };
}