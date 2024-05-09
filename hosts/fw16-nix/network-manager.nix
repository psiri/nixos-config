{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  ########################################
  # PRIMARY WIREGUARD CONNECTION PROFILE #
  ########################################

  sops.templates."nm-wireguard-primary".path = "/etc/NetworkManager/system-connections/BBG-WIREGUARD-PRIMARY.nmconnection";
  sops.templates."nm-wireguard-primary".owner = "root";
  sops.templates."nm-wireguard-primary".mode = "0600";
  sops.templates."nm-wireguard-primary".content = ''
[connection]
id=BBG-WIREGUARD-PRIMARY
type=wireguard
autoconnect=false
interface-name=wg0
permissions=user:psiri:;

[wireguard]
mtu=1420
peer-routes=false
private-key=${config.sops.placeholder.wireguard_private_key_primary}

[wireguard-peer.${config.sops.placeholder.wireguard_peer_uuid_primary}]
endpoint=${config.sops.placeholder.wireguard_peer_address_primary}:${config.sops.placeholder.wireguard_peer_port_primary}
preshared-key=${config.sops.placeholder.wireguard_psk_primary}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=${config.sops.placeholder.wireguard_allowed_ips_primary}

[ipv4]
address1=${config.sops.placeholder.wireguard_ip_primary}
dns=${config.sops.placeholder.wireguard_dns_primary}
dns-search=${config.sops.placeholder.wireguard_search_domains_primary}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=true
${config.sops.placeholder.wireguard_routes_primary}

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';

  ##########################################
  # SECONDARY WIREGUARD CONNECTION PROFILE #
  ##########################################
  sops.templates."nm-wireguard-secondary".path = "/etc/NetworkManager/system-connections/BBG-WIREGUARD-SECONDARY.nmconnection";
  sops.templates."nm-wireguard-secondary".owner = "root";
  sops.templates."nm-wireguard-secondary".mode = "0600";
  sops.templates."nm-wireguard-secondary".content = ''
[connection]
id=BBG-WIREGUARD-SECONDARY
type=wireguard
autoconnect=false
interface-name=wg0
permissions=user:psiri:;

[wireguard]
mtu=1420
peer-routes=false
private-key=${config.sops.placeholder.wireguard_private_key_secondary}

[wireguard-peer.7f0076aa-36f5-4cf8-97c0-945dcb087698]
endpoint=${config.sops.placeholder.wireguard_peer_address_secondary}:${config.sops.placeholder.wireguard_peer_port_secondary}
preshared-key=${config.sops.placeholder.wireguard_psk_secondary}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=${config.sops.placeholder.wireguard_allowed_ips_secondary}

[ipv4]
address1=${config.sops.placeholder.wireguard_ip_secondary}
dns=${config.sops.placeholder.wireguard_dns_secondary}
dns-search=${config.sops.placeholder.wireguard_search_domains_secondary}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=true
${config.sops.placeholder.wireguard_routes_secondary}

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';

  ####################################
  # PRIMARY WIRED CONNECTION PROFILE #
  ####################################
  sops.templates."bbg-wired-1".path = "/etc/NetworkManager/system-connections/BBG-WIRED-1.nmconnection";
  sops.templates."bbg-wired-1".owner = "root";
  sops.templates."bbg-wired-1".mode = "0600";
  sops.templates."bbg-wired-1".content = ''
[connection]
id=BBG-WIRED-1
type=ethernet
autoconnect-priority=-999
interface-name=enp193s0f3u2u1

[ethernet]

[ipv4]
address1=${config.sops.placeholder.wired_connection_1_ip}
dns=${config.sops.placeholder.wired_connection_1_dns}
dns-search=${config.sops.placeholder.wired_connection_1_search_domains}
may-fail=false
method=manual

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';

  #######################################
  # PRIMARY WIRELESS CONNECTION PROFILE #
  #######################################
  sops.templates."bbg-wireless".path = "/etc/NetworkManager/system-connections/BBG-WIRELESS.nmconnection";
  sops.templates."bbg-wireless".owner = "root";
  sops.templates."bbg-wireless".mode = "0600";
  sops.templates."bbg-wireless".content = ''
[connection]
id=BBG-WIRELESS
type=wifi
permissions=user:psiri:;

[wifi]
mode=infrastructure
ssid=${config.sops.placeholder.wireless_connection_1_ssid}

[wifi-security]
key-mgmt=wpa-eap

[802-1x]
anonymous-identity=${config.sops.placeholder.wireless_connection_1_anonymous_identity}
eap=peap;
identity=${config.sops.placeholder.wireless_connection_1_identity}
password=${config.sops.placeholder.wireless_connection_1_password}
phase2-auth=mschapv2

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';
}