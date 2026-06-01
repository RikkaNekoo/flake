_:{
  services.samba = {
    enable = true;

    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server role" = "standalone server";
        "server min protocol" = "SMB2";
        "map to guest" = "bad user";

        "use sendfile" = "yes";

        "aio read size" = 1;
        "aio write size" = 1;

        "vfs objects" = "catia fruit streams_xattr";

        "fruit:copyfile" = "yes";
        "fruit:nfs_aces" = "no";
        "fruit:metadata" = "stream";
        "fruit:resource" = "stream";
        "fruit:locking" = "netatalk";
        "fruit:encoding" = "native";
        "fruit:model" = "TimeCapsule";
      };

      TimeMachine = {
        path = "/data/TimeMachine";
        "read only" = "no";
        browseable = "yes";

        "valid users" = "rikka";
        "force user" = "rikka";
        "force group" = "users";

        "create mask" = "0755";
        "directory mask" = "0755";

        "fruit:time machine" = "yes";
      };

      Files = {
        path = "/data";
        "read only" = "no";
        browseable = "yes";

        "valid users" = "rikka";
        "force user" = "rikka";
        "force group" = "users";

        "create mask" = "0755";
        "directory mask" = "0755";
      };
    };
  };

  # Enable Avahi for mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };

    extraServiceFiles = {
      timemachine = ''
        <?xml version="1.0" standalone='no'?>
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">

        <service-group>
          <name replace-wildcards="yes">%h</name>

          <service>
            <type>_device-info._tcp</type>
            <port>0</port>
            <txt-record>model=TimeCapsule</txt-record>
          </service>

          <service>
            <type>_adisk._tcp</type>
            <txt-record>dk0=adVN=TimeMachine,adVF=0x82</txt-record>
            <txt-record>sys=waMa=0,adVF=0x100</txt-record>
          </service>

          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };
}