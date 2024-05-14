{
  config,
  inputs,
  outputs,
  pkgs,
  user,
  ...
}: {

  #######################################################
  # PRIMARY WIREGUARD CONNECTION PROFILE - SPLIT-TUNNEL #
  #######################################################

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
private-key=${config.sops.placeholder.wireguard_connection_1_private_key}

[wireguard-peer.${config.sops.placeholder.wireguard_connection_1_peer_public_key}]
endpoint=${config.sops.placeholder.wireguard_connection_1_peer_address}:${config.sops.placeholder.wireguard_connection_1_peer_port}
preshared-key=${config.sops.placeholder.wireguard_connection_1_psk}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=${config.sops.placeholder.wireguard_connection_1_allowed_ips}

[ipv4]
address1=${config.sops.placeholder.wireguard_connection_1_ip}
dns=${config.sops.placeholder.wireguard_connection_1_dns}
dns-search=${config.sops.placeholder.wireguard_connection_1_search_domains}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=true
${config.sops.placeholder.wireguard_connection_1_routes}

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';

  ######################################################
  # PRIMARY WIREGUARD CONNECTION PROFILE - FULL-TUNNEL #
  ######################################################
  sops.templates."nm-wireguard-primary-full".path = "/etc/NetworkManager/system-connections/BBG-WIREGUARD-PRIMARY-FULL.nmconnection";
  sops.templates."nm-wireguard-primary-full".owner = "root";
  sops.templates."nm-wireguard-primary-full".mode = "0600";
  sops.templates."nm-wireguard-primary-full".content = ''
[connection]
id=BBG-WIREGUARD-PRIMARY-FULL
type=wireguard
autoconnect=false
interface-name=wg0
permissions=user:psiri:;

[wireguard]
mtu=1420
peer-routes=false
private-key=${config.sops.placeholder.wireguard_connection_1_private_key}
ip4-auto-default-route=true

[wireguard-peer.${config.sops.placeholder.wireguard_connection_1_peer_public_key}]
endpoint=${config.sops.placeholder.wireguard_connection_1_peer_address}:${config.sops.placeholder.wireguard_connection_1_peer_port}
preshared-key=${config.sops.placeholder.wireguard_connection_1_psk}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=0.0.0.0/0;::/0;

[ipv4]
address1=${config.sops.placeholder.wireguard_connection_1_ip}
dns=${config.sops.placeholder.wireguard_connection_1_dns}
dns-search=${config.sops.placeholder.wireguard_connection_1_search_domains}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=false
${config.sops.placeholder.wireguard_connection_1_routes_full}

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';

  #########################################################
  # SECONDARY WIREGUARD CONNECTION PROFILE - SPLIT-TUNNEL #
  #########################################################
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
private-key=${config.sops.placeholder.wireguard_connection_2_private_key}

[wireguard-peer.${config.sops.placeholder.wireguard_connection_2_peer_public_key}]
endpoint=${config.sops.placeholder.wireguard_connection_2_peer_address}:${config.sops.placeholder.wireguard_connection_2_peer_port}
preshared-key=${config.sops.placeholder.wireguard_connection_2_psk}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=${config.sops.placeholder.wireguard_connection_2_allowed_ips}

[ipv4]
address1=${config.sops.placeholder.wireguard_connection_2_ip}
dns=${config.sops.placeholder.wireguard_connection_2_dns}
dns-search=${config.sops.placeholder.wireguard_connection_2_search_domains}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=true
${config.sops.placeholder.wireguard_connection_2_routes}

[ipv6]
addr-gen-mode=default
method=disabled

[proxy]
  '';

  ######################################################
  # SECONDARY WIREGUARD CONNECTION PROFILE FULL-TUNNEL #
  ######################################################
  sops.templates."nm-wireguard-secondary-full".path = "/etc/NetworkManager/system-connections/BBG-WIREGUARD-SECONDARY-FULL.nmconnection";
  sops.templates."nm-wireguard-secondary-full".owner = "root";
  sops.templates."nm-wireguard-secondary-full".mode = "0600";
  sops.templates."nm-wireguard-secondary-full".content = ''
[connection]
id=BBG-WIREGUARD-SECONDARY-FULL
type=wireguard
autoconnect=false
interface-name=wg0
permissions=user:psiri:;

[wireguard]
mtu=1420
peer-routes=false
private-key=${config.sops.placeholder.wireguard_connection_2_private_key}
ip4-auto-default-route=true

[wireguard-peer.${config.sops.placeholder.wireguard_connection_2_peer_public_key}]
endpoint=${config.sops.placeholder.wireguard_connection_2_peer_address}:${config.sops.placeholder.wireguard_connection_2_peer_port}
preshared-key=${config.sops.placeholder.wireguard_connection_2_psk}
preshared-key-flags=0
persistent-keepalive=25
allowed-ips=0.0.0.0/0;::/0;

[ipv4]
address1=${config.sops.placeholder.wireguard_connection_2_ip}
dns=${config.sops.placeholder.wireguard_connection_2_dns}
dns-search=${config.sops.placeholder.wireguard_connection_2_search_domains}
ignore-auto-dns=true
ignore-auto-routes=true
may-fail=false
method=manual
never-default=false
${config.sops.placeholder.wireguard_connection_2_routes_full}

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
autoconnect-priority=999
autoconnect=true

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

  ####################################
  # WORK WIRELESS CONNECTION PROFILE #
  ####################################
  # This example treats the entire connection profile config as a single secret
  sops.templates."work-wireless-1".path = "/etc/NetworkManager/system-connections/WORK-1.nmconnection";
  sops.templates."work-wireless-1".owner = "root";
  sops.templates."work-wireless-1".mode = "0600";
  sops.templates."work-wireless-1".content = ''
  ${config.sops.placeholder.wireless_connection_2}
  '';

}