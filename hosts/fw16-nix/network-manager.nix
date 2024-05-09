{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  sops.templates."nm-wireguard-primary".path = "/etc/NetworkManager/system-connections/BBG-WIREGUARD-PRIMARY.nmconnection";
  sops.templates."nm-wireguard-primary".owner = "root";
  sops.templates."nm-wireguard-primary".mode = "0600";
  sops.templates."nm-wireguard-primary".content = ''
[connection]
id=BBG-WIREGUARD-PRIMARY
uuid=b97fb374-db26-4192-812d-3b49f14fdfaf
type=wireguard
autoconnect=false
interface-name=wg0
permissions=user:psiri:;

[wireguard]
mtu=1420
peer-routes=false
private-key=${config.sops.placeholder.fw16/wireguard_private_key_primary}

[wireguard-peer.${config.sops.placeholder.fw16/wireguard_peer_uuid_primary}]
endpoint=${config.sops.placeholder.fw16/wireguard_peer_address_primary}:${config.sops.placeholder.fw16/wireguard_peer_port_primary}
preshared-key=${config.sops.placeholder.fw16/wireguard_psk_primary}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=${config.sops.placeholder.fw16/wireguard_allowed_ips_primary}

[ipv4]
address1=${config.sops.placeholder.fw16/wireguard_ip_primary}
dns=${config.sops.placeholder.fw16/wireguard_dns_primary}
dns-search=${config.sops.placeholder.fw16/wireguard_search_domains_primary}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=true
${config.sops.placeholder.fw16/wireguard_allowed_routes_primary}

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';
}
