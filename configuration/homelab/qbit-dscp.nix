{ pkgs, ... }: 

{
  networking.nftables = {
    enable = true;
    checkRuleset = false;
    ruleset = ''
      table inet filter {
        set qb_cgroup {
          type cgroupsv2
        }

        chain output {
          type filter hook output priority 0; policy accept;
          socket cgroupv2 level 3 @qb_cgroup ip dscp set ef counter
          socket cgroupv2 level 3 @qb_cgroup ip6 dscp set ef counter
        }
      }
    '';
  };

  # TODO: Shit implement
  systemd.services.podman-qbittorrent.postStart = ''
  cg=$(
    ${pkgs.podman}/bin/podman inspect qbittorrent \
      | ${pkgs.jq}/bin/jq -r '.[0].State.CgroupPath'
  )

  cg=$(echo "$cg" | sed 's#^/##')
  cg="$cg/container"

  ${pkgs.nftables}/bin/nft flush set inet filter qb_cgroup
  ${pkgs.nftables}/bin/nft add element inet filter qb_cgroup "{ \"$cg\" }"
'';
}