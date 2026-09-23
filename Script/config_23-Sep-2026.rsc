# 2026-09-23 10:51:55 by RouterOS 7.24.2
# software id = FVAU-Y91B
#
# model = RB951Ui-2nD
# serial number = F11B0FDD7C16
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-baseT-half,10M-baseT-full,100M-baseT-half,100M-baseT-full arp=enabled \
    arp-timeout=10m auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no l2mtu=2028 loop-protect=on loop-protect-disable-time=5m \
    loop-protect-send-interval=5s mac-address=DC:2C:6E:3C:83:58 mtu=2028 \
    name=ISP orig-mac-address=DC:2C:6E:3C:83:58 rx-flow-control=off \
    tx-flow-control=off
set [ find default-name=ether2 ] advertise=\
    10M-baseT-half,10M-baseT-full,100M-baseT-half,100M-baseT-full arp=enabled \
    arp-timeout=5s auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no l2mtu=1598 loop-protect=on loop-protect-disable-time=5m \
    loop-protect-send-interval=5s mac-address=DC:2C:6E:3C:83:59 mtu=1500 \
    name=ether2-PRIVATE-TV orig-mac-address=DC:2C:6E:3C:83:59 \
    rx-flow-control=off tx-flow-control=off
set [ find default-name=ether3 ] advertise=\
    10M-baseT-half,10M-baseT-full,100M-baseT-half,100M-baseT-full arp=enabled \
    arp-timeout=10s auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no l2mtu=1598 loop-protect=default loop-protect-disable-time=5m \
    loop-protect-send-interval=5s mac-address=DC:2C:6E:3C:83:5A mtu=1500 \
    name=ether3-LAN orig-mac-address=DC:2C:6E:3C:83:5A rx-flow-control=auto \
    tx-flow-control=off
set [ find default-name=ether4 ] advertise=\
    10M-baseT-half,10M-baseT-full,100M-baseT-half,100M-baseT-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no l2mtu=1598 loop-protect=default loop-protect-disable-time=5m \
    loop-protect-send-interval=5s mac-address=DC:2C:6E:3C:83:5B mtu=1500 \
    name=ether4-PPPOE orig-mac-address=DC:2C:6E:3C:83:5B rx-flow-control=off \
    tx-flow-control=off
set [ find default-name=ether5 ] advertise=\
    10M-baseT-half,10M-baseT-full,100M-baseT-half,100M-baseT-full arp=enabled \
    arp-timeout=5s auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no l2mtu=1598 loop-protect=default loop-protect-disable-time=5m \
    loop-protect-send-interval=5s mac-address=DC:2C:6E:3C:83:5C mtu=1500 \
    name="ether5-PRIVATE-Wireless " orig-mac-address=DC:2C:6E:3C:83:5C \
    poe-out=auto-on poe-priority=10 power-cycle-interval=none \
    !power-cycle-ping-address power-cycle-ping-enabled=no \
    !power-cycle-ping-timeout rx-flow-control=auto tx-flow-control=auto
/disk
set usb1 compress=no disabled=no media-interface=none media-sharing=no \
    mount-filesystem=yes !mount-point-template mount-read-only=no parent="" \
    slot=usb1 smb-sharing=no swap=no type=hardware
/interface ethernet switch
set switchVLAN cpu-flow-control=yes mirror-source=none mirror-target=cpu \
    name=switchVLAN
/interface ethernet switch port
set ISP default-vlan-id=0 vlan-header=leave-as-is vlan-mode=disabled
set ether2-PRIVATE-TV default-vlan-id=100 vlan-header=leave-as-is vlan-mode=\
    disabled
set ether3-LAN default-vlan-id=300 vlan-header=leave-as-is vlan-mode=disabled
set ether4-PPPOE default-vlan-id=0 vlan-header=leave-as-is vlan-mode=disabled
set "ether5-PRIVATE-Wireless " default-vlan-id=0 vlan-header=leave-as-is \
    vlan-mode=disabled
set switchVLAN-cpu default-vlan-id=0 vlan-header=leave-as-is vlan-mode=\
    disabled
/interface ethernet switch port-isolation
set ISP !forwarding-override
set ether2-PRIVATE-TV !forwarding-override
set ether3-LAN !forwarding-override
set ether4-PPPOE !forwarding-override
set "ether5-PRIVATE-Wireless " !forwarding-override
set switchVLAN-cpu !forwarding-override
/interface list
set [ find name=all ] comment="contains all interfaces" exclude="" include="" \
    name=all
set [ find name=none ] comment="contains no interfaces" exclude="" include="" \
    name=none
set [ find name=dynamic ] comment="contains dynamic interfaces" exclude="" \
    include="" name=dynamic
set [ find name=static ] comment="contains static interfaces" exclude="" \
    include="" name=static
add exclude="" include="" name=WAN
add exclude="" include="" name=LAN
add exclude=dynamic,static include=LAN,WAN name=Local
add exclude="" include=LAN,dynamic name=list-_local_only
add exclude="" include=static name=list_public
add exclude="" include=list-_local_only,list_public name=list-ttl1
/interface lte apn
set [ find default=yes ] add-default-route=yes apn=internet authentication=\
    none default-route-distance=2 ip-type=auto name=default use-network-apn=\
    yes use-peer-dns=yes
/interface macsec profile
set [ find default-name=default ] ciphers=aes-gcm-128 name=default \
    server-priority=10
/interface wireless security-profiles
set [ find default=yes ] authentication-types="" disable-pmkid=no \
    eap-methods=passthrough group-ciphers=aes-ccm group-key-update=5m \
    interim-update=0s management-protection=disabled mode=none \
    mschapv2-username="" name=default radius-called-format=mac:ssid \
    radius-eap-accounting=no radius-mac-accounting=no \
    radius-mac-authentication=no radius-mac-caching=disabled \
    radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity=MikroTik tls-certificate=none tls-mode=\
    no-certificates unicast-ciphers=aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=tkip,aes-ccm group-key-update=23h5m \
    interim-update=0s management-protection=allowed mode=dynamic-keys \
    mschapv2-username="" name=HOME_Pass radius-called-format=mac:ssid \
    radius-eap-accounting=no radius-mac-accounting=no \
    radius-mac-authentication=no radius-mac-caching=disabled \
    radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity="" tls-certificate=none tls-mode=no-certificates \
    unicast-ciphers=tkip,aes-ccm
add authentication-types=wpa2-psk disable-pmkid=no eap-methods=passthrough \
    group-ciphers=tkip,aes-ccm group-key-update=5m interim-update=0s \
    management-protection=disabled mode=dynamic-keys mschapv2-username="" \
    name="Hotspot hp" radius-called-format=mac:ssid radius-eap-accounting=no \
    radius-mac-accounting=no radius-mac-authentication=no radius-mac-caching=\
    disabled radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity="" tls-certificate=none tls-mode=no-certificates \
    unicast-ciphers=tkip,aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=tkip,aes-ccm group-key-update=5m \
    interim-update=0s management-protection=disabled mode=dynamic-keys \
    mschapv2-username="" name=profile1 radius-called-format=mac:ssid \
    radius-eap-accounting=no radius-mac-accounting=no \
    radius-mac-authentication=no radius-mac-caching=disabled \
    radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity="" tls-certificate=none tls-mode=no-certificates \
    unicast-ciphers=tkip,aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=tkip,aes-ccm group-key-update=23h5m \
    interim-update=0s management-protection=allowed mode=dynamic-keys \
    mschapv2-username="" name=HOME1 radius-called-format=mac:ssid \
    radius-eap-accounting=no radius-mac-accounting=no \
    radius-mac-authentication=no radius-mac-caching=disabled \
    radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity="" tls-certificate=none tls-mode=no-certificates \
    unicast-ciphers=tkip,aes-ccm
add authentication-types=wpa2-psk disable-pmkid=no eap-methods=passthrough \
    group-ciphers=aes-ccm group-key-update=5m interim-update=0s \
    management-protection=allowed mode=dynamic-keys mschapv2-username="" \
    name=extender radius-called-format=mac:ssid radius-eap-accounting=no \
    radius-mac-accounting=no radius-mac-authentication=no radius-mac-caching=\
    disabled radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity=MikroTik tls-certificate=none tls-mode=\
    no-certificates unicast-ciphers=aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=aes-ccm group-key-update=5m interim-update=0s \
    management-protection=allowed mode=dynamic-keys mschapv2-username="" \
    name=MinecraftUser radius-called-format=mac:ssid radius-eap-accounting=no \
    radius-mac-accounting=no radius-mac-authentication=no radius-mac-caching=\
    disabled radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity=MikroTik tls-certificate=none tls-mode=\
    no-certificates unicast-ciphers=tkip,aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=aes-ccm group-key-update=5m interim-update=0s \
    management-protection=allowed mode=dynamic-keys mschapv2-username="" \
    name=@claudio radius-called-format=mac:ssid radius-eap-accounting=no \
    radius-mac-accounting=no radius-mac-authentication=no radius-mac-caching=\
    disabled radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity=MikroTik tls-certificate=none tls-mode=\
    no-certificates unicast-ciphers=aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=aes-ccm group-key-update=5m interim-update=0s \
    management-protection=required mode=dynamic-keys mschapv2-username="" \
    name=SmartHome radius-called-format=mac:ssid radius-eap-accounting=no \
    radius-mac-accounting=no radius-mac-authentication=no radius-mac-caching=\
    disabled radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity=MikroTik tls-certificate=none tls-mode=\
    no-certificates unicast-ciphers=tkip,aes-ccm
add authentication-types=wpa-psk,wpa2-psk disable-pmkid=no eap-methods=\
    passthrough group-ciphers=aes-ccm group-key-update=5m interim-update=0s \
    management-protection=allowed mode=dynamic-keys mschapv2-username="" \
    name=IoT radius-called-format=mac:ssid radius-eap-accounting=no \
    radius-mac-accounting=no radius-mac-authentication=no radius-mac-caching=\
    disabled radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-sta-private-algo=none static-transmit-key=key-0 \
    supplicant-identity=MikroTik tls-certificate=none tls-mode=\
    no-certificates unicast-ciphers=aes-ccm
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=none allow-sharedkey=\
    no ampdu-priorities=0 amsdu-limit=8192 amsdu-threshold=8192 antenna-gain=\
    2 area="" arp=enabled arp-timeout=1m band=2ghz-g/n basic-rates-a/g=6Mbps \
    basic-rates-b=1Mbps bridge-mode=enabled channel-width=20/40mhz-Ce \
    compression=no country=indonesia2 default-ap-tx-limit=0 \
    default-authentication=yes default-client-tx-limit=0 default-forwarding=\
    yes disable-running-check=no disabled=no disconnect-timeout=3s distance=\
    dynamic frame-lifetime=0 frequency=auto frequency-mode=regulatory-domain \
    frequency-offset=0 guard-interval=any hide-ssid=no ht-basic-mcs=\
    mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7 ht-supported-mcs="mcs-0,mc\
    s-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,m\
    cs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-2\
    3" hw-fragmentation-threshold=disabled hw-protection-mode=none \
    hw-protection-threshold=0 hw-retries=7 installation=any \
    interworking-profile=disabled keepalive-frames=enabled l2mtu=2290 \
    mac-address=DC:2C:6E:3C:83:5D max-station-count=2007 mode=ap-bridge mtu=\
    2290 multicast-buffering=enabled multicast-helper=default name=\
    wlan1-HOTSPOT noise-floor-threshold=default nv2-cell-radius=30 \
    nv2-downlink-ratio=50 nv2-mode=dynamic-downlink nv2-noise-floor-offset=\
    default nv2-qos=frame-priority nv2-queue-count=2 nv2-security=disabled \
    nv2-sync-secret="" on-fail-retry-time=100ms preamble-mode=both \
    radio-name=DC2C6E3C835D rate-selection=advanced rate-set=default \
    rx-chains=0,1 scan-list=default secondary-frequency="" security-profile=\
    default skip-dfs-channels=disabled ssid="Free WiFi Linelejan - Rumagit" \
    station-bridge-clone-mac=00:00:00:00:00:00 station-roaming=disabled \
    supported-rates-a/g=6Mbps,9Mbps,12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps \
    supported-rates-b=1Mbps,2Mbps,5.5Mbps,11Mbps tdma-period-size=2 \
    tx-chains=0,1 tx-power-mode=default update-stats-interval=disabled \
    vlan-id=1 vlan-mode=no-tag wds-cost-range=50-150 wds-default-bridge=none \
    wds-default-cost=100 wds-ignore-ssid=no wds-mode=disabled \
    wireless-protocol=802.11 wmm-support=disabled wps-mode=push-button
/interface wireless manual-tx-power-table
set wlan1-HOTSPOT manual-tx-powers="1Mbps:17,2Mbps:17,5.5Mbps:17,11Mbps:17,6Mb\
    ps:17,9Mbps:17,12Mbps:17,18Mbps:17,24Mbps:17,36Mbps:17,48Mbps:17,54Mbps:17\
    ,HT20-0:17,HT20-1:17,HT20-2:17,HT20-3:17,HT20-4:17,HT20-5:17,HT20-6:17,HT2\
    0-7:17,HT40-0:17,HT40-1:17,HT40-2:17,HT40-3:17,HT40-4:17,HT40-5:17,HT40-6:\
    17,HT40-7:17"
/interface wireless
add area="" arp=local-proxy-arp arp-timeout=auto bridge-mode=enabled \
    default-ap-tx-limit=0 default-authentication=yes default-client-tx-limit=\
    0 default-forwarding=yes disable-running-check=no disabled=yes hide-ssid=\
    no interworking-profile=disabled keepalive-frames=enabled l2mtu=1600 \
    mac-address=DE:2C:6E:3C:83:5E master-interface=wlan1-HOTSPOT \
    max-station-count=2007 mode=ap-bridge mtu=1500 multicast-buffering=\
    enabled multicast-helper=default name=i security-profile=@claudio ssid=\
    "H\E2\88\85me" station-bridge-clone-mac=00:00:00:00:00:00 \
    station-roaming=disabled update-stats-interval=disabled vlan-id=1 \
    vlan-mode=no-tag wds-cost-range=50-150 wds-default-bridge=none \
    wds-default-cost=100 wds-ignore-ssid=no wds-mode=disabled wmm-support=\
    disabled wps-mode=disabled
/ip dhcp-client option
set clientid_duid code=61 name=clientid_duid value="0xff\$(CLIENT_DUID)"
set clientid code=61 name=clientid value="0x01\$(CLIENT_MAC)"
set hostname code=12 name=hostname value="\$(HOSTNAME)"
/ip dhcp-server option
add code=12 name=hostname value=""
add code=6 force=yes name=DNS value=""
add code=35 force=yes name="ARP timeout" value=""
add code=50 force=yes name="Request IP Address" value=""
add code=3 name=router/gateway value=""
add code=42 name=NTP value=""
add code=15 name="Domain Name" value=""
/ip dns forwarders
add disabled=yes dns-servers=94.140.14.59,94.140.14.49 doh-servers="https://d.\
    adguard-dns.com/dns-query/93fca145,https://d.adguard-dns.com/dns-query/5e4\
    8d7bf" name=1d.adguard-dns.com
add disabled=yes dns-servers=172.64.36.1,172.64.36.2 doh-servers=\
    https://rjmc5uqmy8.cloudflare-gateway.com/dns-query name=\
    "Cloudflare Zero Trust" verify-doh-cert=no
/ip firewall layer7-protocol
add name=tiktok regexp="^.+(tiktokcdn\\.com|tiktokv\\.com|tiktok\\.com|bytecdn\
    \\.com|ibytedtos\\.com).*"
/ip hotspot profile
set [ find default=yes ] dns-name="" hotspot-address=0.0.0.0 html-directory=\
    hotspot html-directory-override="" http-cookie-lifetime=3d http-proxy=\
    0.0.0.0:0 install-hotspot-queue=no login-by=cookie,http-chap name=default \
    smtp-server=0.0.0.0 split-user-domain=no use-radius=no
add dns-name=gateway.linelejan-rumagit.net hotspot-address=10.10.10.1 \
    html-directory=flash/hotspot html-directory-override="" http-proxy=\
    0.0.0.0:0 install-hotspot-queue=no login-by=http-chap,http-pap name=\
    hsprof1 smtp-server=0.0.0.0 split-user-domain=no use-radius=no
/ip hotspot user profile
set [ find default=yes ] add-mac-cookie=yes address-list="" !idle-timeout \
    !insert-queue-before !keepalive-timeout mac-cookie-timeout=4w2d name=\
    default !parent-queue !queue-type shared-users=unlimited \
    status-autorefresh=5s transparent-proxy=no
add add-mac-cookie=yes address-list="" advertise=no idle-timeout=none \
    !insert-queue-before keepalive-timeout=12w6d2m mac-cookie-timeout=1w \
    name=ryo open-status-page=always !parent-queue !queue-type shared-users=1 \
    status-autorefresh=1m transparent-proxy=yes
add add-mac-cookie=yes address-list="" advertise=no idle-timeout=10m \
    !insert-queue-before keepalive-timeout=2m mac-cookie-timeout=3d name=\
    2DayLimit open-status-page=always !parent-queue !queue-type \
    session-timeout=2d shared-users=1 status-autorefresh=1m \
    transparent-proxy=yes
add add-mac-cookie=no address-list=gameOnlyUser advertise=no idle-timeout=30s \
    !insert-queue-before keepalive-timeout=2m !mac-cookie-timeout name=game \
    on-login="# ==============================\
    \n# Hotspot Login Notification to Telegram\
    \n# Version: 6.0 (Added Hotspot User)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :do {\
    \n        :local activeID [/ip hotspot active find mac-address=\$macaddr]\
    \n        :if ([:len \$activeID] > 0) do={\
    \n            :local activeHost [/ip hotspot active get [:pick \$activeID \
    0] host-name]\
    \n            :if ([:len \$activeHost] > 0) do={ \
    \n                :set hostname \$activeHost \
    \n            }\
    \n        }\
    \n    } on-error={}\
    \n}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n:log info (\"LOGIN - User: \$username | IP: \$ipaddr | MAC: \$macaddr | \
    Hostname: \$hostname\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"HOTSPOT LOGIN%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n# <--- TAMBAHAN DI SINI\
    \n:set msg (\$msg . \"User: \" . \$username . \"%0A\")\
    \n# <--- AKHIR TAMBAHAN\
    \n:set msg (\$msg . \"Hostname: \" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP Address: \" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC Address: \" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date: \" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time: \" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGIN sent: \" . \$hostname . \" (\" . \$ipadd\
    r . \")\")\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGIN: \" . \$hostname)\
    \n}" on-logout="# ==============================\
    \n# Hotspot Logout Notification to Telegram\
    \n# Version: 6.1 (Fixed Swapped Traffic)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# Ambil Traffic Usage\
    \n# ----------------\
    \n:local bytesIn 0\
    \n:local bytesOut 0\
    \n:if ([:typeof \$\"bytes-in\"] != \"nothing\") do={ \
    \n    :set bytesIn \$\"bytes-in\" \
    \n}\
    \n:if ([:typeof \$\"bytes-out\"] != \"nothing\") do={ \
    \n    :set bytesOut \$\"bytes-out\" \
    \n}\
    \n:local totalBytes (\$bytesIn + \$bytesOut)\
    \n\
    \n:log info (\"LOGOUT - IP: \$ipaddr | MAC: \$macaddr | Hostname: \$hostna\
    me | Down: \$bytesOut | Up: \$bytesIn\")\
    \n\
    \n# ----------------\
    \n# Fungsi Konversi Bytes (Ini sudah benar)\
    \n# ----------------\
    \n:local convertBytes do={\
    \n    :local bytes [:tonum \$1]\
    \n    :if (\$bytes = 0) do={ :return \"0 Bytes\" }\
    \n    :if (\$bytes >= 1099511627776) do={ :local value (\$bytes / 10995116\
    27776); :return ([:tostr \$value] . \" TB\") }\
    \n    :if (\$bytes >= 1073741824) do={ :local value (\$bytes / 1073741824)\
    ; :return ([:tostr \$value] . \" GB\") }\
    \n    :if (\$bytes >= 1048576) do={ :local value (\$bytes / 1048576); :ret\
    urn ([:tostr \$value] . \" MB\") }\
    \n    :if (\$bytes >= 1024) do={ :local value (\$bytes / 1024); :return ([\
    :tostr \$value] . \" KB\") }\
    \n    :return ([:tostr \$bytes] . \" Bytes\")\
    \n}\
    \n\
    \n# <--- PERBAIKAN DI SINI\
    \n# bytesOut adalah Download (data ke klien)\
    \n# bytesIn adalah Upload (data dari klien)\
    \n:local downloadSize [\$convertBytes \$bytesOut]\
    \n:local uploadSize [\$convertBytes \$bytesIn]\
    \n# <--- AKHIR PERBAIKAN\
    \n:local totalSize [\$convertBytes \$totalBytes]\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"HOTSPOT LOGOUT%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User: \" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname: \" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP Address: \" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC Address: \" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date: \" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time: \" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"Download: \" . \$downloadSize . \"%0A\")\
    \n:set msg (\$msg . \"Upload: \" . \$uploadSize . \"%0A\")\
    \n:set msg (\$msg . \"Total: \" . \$totalSize . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGOUT sent: \" . \$hostname . \" | Traffic: \
    \" . \$totalSize)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGOUT: \" . \$hostname)\
    \n}" open-status-page=http-login !parent-queue !queue-type rate-limit=\
    1m/1m session-timeout=10h5m shared-users=5 status-autorefresh=1m \
    transparent-proxy=yes
add add-mac-cookie=yes address-list="" advertise=no idle-timeout=1h \
    !insert-queue-before keepalive-timeout=2m mac-cookie-timeout=3d name=juan \
    open-status-page=always !parent-queue !queue-type rate-limit=11m \
    shared-users=1 status-autorefresh=1m transparent-proxy=yes
/ip hotspot profile
add dns-name=linelejan-rumagit.hotspot hotspot-address=10.10.10.1 \
    html-directory=flash/hotspot html-directory-override="" http-proxy=\
    0.0.0.0:0 install-hotspot-queue=no login-by=http-pap,trial name=\
    hsprof_tamu smtp-server=0.0.0.0 split-user-domain=no trial-uptime-limit=\
    30m trial-uptime-reset=1w trial-user-profile=default use-radius=no
/ip ipsec mode-config
set [ find default=yes ] name=request-only responder=no use-responder-dns=\
    exclusively
/ip ipsec policy group
set [ find default=yes ] name=default
/ip ipsec profile
set [ find default=yes ] dh-group=modp2048,modp1024 dpd-interval=2m \
    dpd-maximum-failures=5 enc-algorithm=aes-128,3des hash-algorithm=sha1 \
    lifetime=1d name=default nat-traversal=yes ppk=no proposal-check=obey
/ip ipsec proposal
set [ find default=yes ] auth-algorithms=sha1 disabled=no enc-algorithms=\
    aes-256-cbc,aes-192-cbc,aes-128-cbc lifetime=30m name=default pfs-group=\
    modp1024
/ip kid-control
add disabled=no fri=0s-1d mon=0s-1d name=system-dummy rate-limit="" sat=0s-1d \
    sun=0s-1d thu=0s-1d tue=0s-1d tur-fri=0s-1d tur-mon=0s-1d tur-sat=0s-1d \
    tur-sun=0s-1d tur-thu=0s-1d tur-tue=0s-1d tur-wed=0s-1d wed=0s-1d
/ip pool
add name=LAN ranges=172.31.1.2-172.31.1.6
add name=hs-pool-Tamu ranges=10.10.10.2-10.10.10.254
add name=hs-tamu-temp ranges=10.10.10.2-10.10.10.4
add name=IoT ranges=172.31.40.10-172.31.40.102
add name=Private-Network ranges=\
    172.31.2.2-172.31.2.5,172.31.2.10,172.31.2.11,172.31.2.12
add name=vpn ranges=192.168.89.2-192.168.89.255
/ip dhcp-server
add add-dns-entries-suffix=lan address-lists="" address-pool=LAN \
    always-broadcast=yes disabled=no dynamic-lease-identifiers=\
    client-mac,client-id interface=ether3-LAN lease-script="" lease-time=30m \
    name=LAN support-broadband-tr101=no use-radius=no use-reconfigure=yes
# Interface not running
add add-dns-entries-suffix=lan address-lists="" address-pool=hs-pool-Tamu \
    always-broadcast=yes disabled=no dynamic-lease-identifiers=\
    client-mac,client-id interface=wlan1-HOTSPOT lease-script="" lease-time=\
    30m name=hotspot support-broadband-tr101=no use-radius=no \
    use-reconfigure=no
/ip hotspot user profile
add add-mac-cookie=yes address-list="" address-pool=hs-pool-Tamu advertise=no \
    idle-timeout=10s !insert-queue-before keepalive-timeout=2m \
    mac-cookie-timeout=3d name=test_1menit open-status-page=always \
    !parent-queue !queue-type session-timeout=1m shared-users=1 \
    status-autorefresh=6s transparent-proxy=yes
/ip smb users
set [ find default=yes ] disabled=no name=guest read-only=yes
add disabled=no name=ryo read-only=no
/ipv6 dhcp-relay option
set client_mac code=79 name=client_mac only-if-mac-available=yes value=\
    "0x0001\$(CLIENT_MAC)"
/ipv6 dhcp-server
add address-lists="" address-pool=2001:6:4::1 dhcp-option="" disabled=no \
    ignore-ia-na-bindings=no interface="ether5-PRIVATE-Wireless " lease-time=\
    3d name=server1 preference=255 prefix-pool=private rapid-commit=yes \
    route-distance=1 use-radius=no use-reconfigure=no
add address-lists="" address-pool=private dhcp-option="" disabled=no \
    ignore-ia-na-bindings=no interface=ether3-LAN lease-time=3d name=\
    server_lan preference=255 prefix-pool=private rapid-commit=yes \
    route-distance=1 use-radius=no use-reconfigure=no
/ipv6 pool
add name=private prefix=2001:6:4:f004:f006:1::/64 prefix-length=64
/ppp profile
set *0 address-list="" !bridge !bridge-horizon bridge-learning=default \
    !bridge-path-cost !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=yes !dhcpv6-lease-time !dhcpv6-use-radius \
    !dns-server !idle-timeout !incoming-filter !insert-queue-before \
    !interface-list !local-address name=default on-down="" on-up="" only-one=\
    default !outgoing-filter !parent-queue !queue-type !rate-limit \
    !remote-address !remote-ipv6-prefix-reuse !session-timeout \
    use-compression=default use-encryption=default use-ipv6=yes use-mpls=\
    default use-upnp=default !wins-server
add address-list="" !bridge !bridge-horizon bridge-learning=default \
    !bridge-path-cost !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=default !dhcpv6-lease-time \
    !dhcpv6-use-radius dns-server=1.1.1.1 !idle-timeout !incoming-filter \
    !insert-queue-before !interface-list !local-address name=ryoo on-down="" \
    on-up="" only-one=default !outgoing-filter !parent-queue !queue-type \
    !rate-limit !remote-address !remote-ipv6-prefix-reuse !session-timeout \
    use-compression=yes use-encryption=yes use-ipv6=yes use-mpls=default \
    use-upnp=default !wins-server
add address-list="" !bridge !bridge-horizon bridge-learning=default \
    !bridge-path-cost !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=default !dhcpv6-lease-time \
    !dhcpv6-use-radius dns-server=192.168.1.2 !idle-timeout !incoming-filter \
    !insert-queue-before !interface-list local-address=10.5.0.1 name=ovpn-ryo \
    on-down="" on-up="" only-one=yes !outgoing-filter !parent-queue \
    !queue-type !rate-limit remote-address=10.5.0.2 !remote-ipv6-prefix-reuse \
    !session-timeout use-compression=default use-encryption=yes use-ipv6=yes \
    use-mpls=default use-upnp=no !wins-server
add address-list="" !bridge !bridge-horizon bridge-learning=default \
    bridge-path-cost=10 !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=default !dhcpv6-lease-time \
    !dhcpv6-use-radius dns-server=1.1.1.1 !idle-timeout !incoming-filter \
    !insert-queue-before !interface-list local-address=192.168.1.2 name=test \
    on-down="" on-up="" only-one=yes !outgoing-filter !parent-queue \
    !queue-type !rate-limit remote-address=99.99.99.99 \
    !remote-ipv6-prefix-reuse !session-timeout use-compression=default \
    use-encryption=yes use-ipv6=yes use-mpls=default use-upnp=yes \
    !wins-server
set *FFFFFFFE address-list="" !bridge !bridge-horizon bridge-learning=default \
    !bridge-path-cost !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=yes !dhcpv6-lease-time !dhcpv6-use-radius \
    !dns-server !idle-timeout !incoming-filter !insert-queue-before \
    !interface-list local-address=192.168.89.1 name=default-encryption \
    on-down="" on-up="" only-one=default !outgoing-filter !parent-queue \
    !queue-type !rate-limit remote-address=vpn !remote-ipv6-prefix-reuse \
    !session-timeout use-compression=default use-encryption=yes use-ipv6=yes \
    use-mpls=default use-upnp=default !wins-server
/queue type
set 0 kind=pfifo name=default pfifo-limit=50
set 1 kind=pfifo name=ethernet-default pfifo-limit=50
set 2 kind=sfq name=wireless-default sfq-allot=1514 sfq-perturb=5
set 3 kind=red name=synchronous-default red-avg-packet=1000 red-burst=20 \
    red-limit=60 red-max-threshold=50 red-min-threshold=10
set 4 kind=sfq name=hotspot-default sfq-allot=1514 sfq-perturb=5
add cake-ack-filter=none cake-bandwidth=0bps cake-diffserv=diffserv3 \
    cake-flowmode=triple-isolate cake-memlimit=32.0MiB cake-nat=no \
    cake-overhead=-64 cake-overhead-scheme="" cake-rtt=1s cake-rtt-scheme=\
    satellite cake-wash=no kind=cake name=optimalisasi-jaringan-sattelite
add cake-ack-filter=none cake-bandwidth=0bps cake-diffserv=diffserv3 \
    cake-flowmode=triple-isolate cake-memlimit=32.0MiB cake-nat=no \
    cake-overhead=-64 cake-overhead-scheme="" cake-rtt=1ms cake-rtt-scheme=\
    lan cake-wash=no kind=cake name="optimalisasi jaringan wlan"
add fq-codel-ecn=yes fq-codel-flows=1024 fq-codel-interval=10ms \
    fq-codel-limit=10240 fq-codel-memlimit=32.0MiB fq-codel-quantum=1514 \
    fq-codel-target=5ms kind=fq-codel name="Game Optimization ping stable"
add kind=pfifo name="Game Low Latency" pfifo-limit=20
set 9 kind=pcq name=pcq-upload-default pcq-burst-rate=0 pcq-burst-threshold=0 \
    pcq-burst-time=10s pcq-classifier=src-address pcq-dst-address-mask=32 \
    pcq-dst-address6-mask=128 pcq-limit=50KiB pcq-rate=0 \
    pcq-src-address-mask=32 pcq-src-address6-mask=128 pcq-total-limit=2000KiB
set 10 kind=pcq name=pcq-download-default pcq-burst-rate=0 \
    pcq-burst-threshold=0 pcq-burst-time=10s pcq-classifier=dst-address \
    pcq-dst-address-mask=32 pcq-dst-address6-mask=128 pcq-limit=50KiB \
    pcq-rate=0 pcq-src-address-mask=32 pcq-src-address6-mask=128 \
    pcq-total-limit=2000KiB
set 11 kind=none name=only-hardware-queue
set 12 kind=mq-pfifo mq-pfifo-limit=50 name=multi-queue-ethernet-default
set 13 kind=pfifo name=default-small pfifo-limit=10
/queue interface
set ISP queue="Game Low Latency"
set ether2-PRIVATE-TV queue=only-hardware-queue
set ether3-LAN queue=only-hardware-queue
set ether4-PPPOE queue=only-hardware-queue
set "ether5-PRIVATE-Wireless " queue="Game Low Latency"
set i queue=wireless-default
set wlan1-HOTSPOT queue=wireless-default
/interface wireless nstreme
set wlan1-HOTSPOT disable-csma=no enable-nstreme=no enable-polling=yes \
    framer-limit=3200 framer-policy=none
/queue simple
add bucket-size=0.1/0.1 burst-limit=20M/68M burst-threshold=2M/4M burst-time=\
    6s/12s comment="PPPOE Traffic " disabled=no limit-at=15M/65M max-limit=\
    20M/65M name=queuePPPOE packet-marks="" parent=none priority=8/8 queue=\
    "default-small/optimalisasi jaringan wlan" target=\
    ether4-PPPOE,100.52.0.0/27 !time total-burst-limit=75M \
    total-burst-threshold=5M total-burst-time=30s total-limit-at=65M \
    total-max-limit=75M
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=no limit-at=1M/100k max-limit=1M/500k name=Tiktok-LimitSpeed \
    packet-marks=TikTok-Packet parent=none priority=8/8 queue=\
    default-small/default-small target=wlan1-HOTSPOT,191.150.81.0/24 !time \
    total-burst-limit=3M total-burst-threshold=1M total-burst-time=5s \
    total-limit-at=1M total-max-limit=2M
add bucket-size=0.1/0.1 burst-limit=9M/18M burst-threshold=2M/4M burst-time=\
    6s/12s comment=TV disabled=yes limit-at=1M/1k max-limit=8M/10M name=TV \
    packet-marks="" parent=none priority=8/8 queue=\
    "default-small/optimalisasi jaringan wlan" target=172.31.2.10/32 !time \
    total-limit-at=20M total-max-limit=20M
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    comment=TV disabled=yes limit-at=1M/1k max-limit=8M/500k name=TV2 \
    packet-marks="" parent=none priority=8/8 queue=\
    "default-small/optimalisasi jaringan wlan" target=172.31.2.10/32 !time
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=yes limit-at=0/0 max-limit=1k/1k name=queue-icmp packet-marks=\
    ICMP-Packet parent=none priority=8/8 queue=default-small/default-small \
    target="" !time
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=100M/100M burst-time=\
    1m/1m disabled=no limit-at=0/0 max-limit=0/0 name=queue-ISP packet-marks=\
    "" parent=none priority=8/8 queue=default-small/default-small target=ISP \
    !time total-burst-limit=100M total-burst-threshold=100M total-burst-time=\
    1m total-queue=pcq-download-default
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=no limit-at=100k/100k max-limit=100k/1M name="Tiktok limit " \
    packet-marks=TikTok-Packet parent=none priority=1/8 queue=\
    pcq-upload-default/pcq-download-default target=wlan1-HOTSPOT !time \
    total-burst-limit=2M total-burst-time=2s total-limit-at=1M \
    total-max-limit=2M
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=yes limit-at=500k/100k max-limit=500k/100k name=queue-Papa \
    packet-marks="" parent=none priority=8/8 queue=\
    default-small/default-small target=172.31.2.5/32 !time
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=no limit-at=500k/100k max-limit=10M/15M name=queue-Papa1 \
    packet-marks="" parent=none priority=8/8 queue=\
    default-small/default-small target=172.31.2.5/32 !time
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=no limit-at=15M/20M max-limit=15M/20M name=HOTSPOT-Traffic \
    packet-marks="" parent=none priority=8/8 queue=\
    hotspot-default/hotspot-default target=wlan1-HOTSPOT !time
/ip hotspot user profile
add add-mac-cookie=no address-list="" address-pool=hs-pool-Tamu advertise=no \
    idle-timeout=1m insert-queue-before=bottom keepalive-timeout=30s \
    !mac-cookie-timeout name=tamu on-login="# ==============================\
    \n# Hotspot Login Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :do {\
    \n        :local activeID [/ip hotspot active find mac-address=\$macaddr]\
    \n        :if ([:len \$activeID] > 0) do={\
    \n            :local activeHost [/ip hotspot active get [:pick \$activeID \
    0] host-name]\
    \n            :if ([:len \$activeHost] > 0) do={ \
    \n                :set hostname \$activeHost \
    \n            }\
    \n        }\
    \n    } on-error={}\
    \n}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n:log info (\"LOGIN - User: \$username | IP: \$ipaddr | MAC: \$macaddr | \
    Hostname: \$hostname\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\9F\A2%20HOTSPOT%20LOGIN%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGIN sent: \" . \$hostname)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGIN: \" . \$hostname)\
    \n}" on-logout="# ==============================\
    \n# Hotspot Logout Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# Ambil Traffic Usage & Konversi\
    \n# ----------------\
    \n:local bytesIn 0\
    \n:local bytesOut 0\
    \n:if ([:typeof \$\"bytes-in\"] != \"nothing\") do={ :set bytesIn \$\"byte\
    s-in\" }\
    \n:if ([:typeof \$\"bytes-out\"] != \"nothing\") do={ :set bytesOut \$\"by\
    tes-out\" }\
    \n:local totalBytes (\$bytesIn + \$bytesOut)\
    \n\
    \n# Fungsi Konversi Bytes (Sekarang menggunakan %20)\
    \n:local convertBytes do={\
    \n    :local bytes [:tonum \$1]\
    \n    :if (\$bytes = 0) do={ :return \"0%20Bytes\" }\
    \n    :if (\$bytes >= 1099511627776) do={ :local value (\$bytes / 10995116\
    27776); :return ([:tostr \$value] . \"%20TB\") }\
    \n    :if (\$bytes >= 1073741824) do={ :local value (\$bytes / 1073741824)\
    ; :return ([:tostr \$value] . \"%20GB\") }\
    \n    :if (\$bytes >= 1048576) do={ :local value (\$bytes / 1048576); :ret\
    urn ([:tostr \$value] . \"%20MB\") }\
    \n    :if (\$bytes >= 1024) do={ :local value (\$bytes / 1024); :return ([\
    :tostr \$value] . \"%20KB\") }\
    \n    :return ([:tostr \$bytes] . \"%20Bytes\")\
    \n}\
    \n\
    \n:local downloadSize [\$convertBytes \$bytesOut]\
    \n:local uploadSize [\$convertBytes \$bytesIn]\
    \n:local totalSize [\$convertBytes \$totalBytes]\
    \n\
    \n:log info (\"LOGOUT - IP: \$ipaddr | MAC: \$macaddr | Hostname: \$hostna\
    me | Traffic: \$totalSize\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\94\B4%20HOTSPOT%20LOGOUT%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"Download:%20\" . \$downloadSize . \"%0A\")\
    \n:set msg (\$msg . \"Upload:%20\" . \$uploadSize . \"%0A\")\
    \n:set msg (\$msg . \"Total:%20\" . \$totalSize . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGOUT sent: \" . \$hostname . \" | Traffic: \
    \" . \$totalSize)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGOUT: \" . \$hostname)\
    \n}" open-status-page=always parent-queue=HOTSPOT-Traffic queue-type=\
    hotspot-default rate-limit=2m/10m session-timeout=20m shared-users=10 \
    status-autorefresh=10s transparent-proxy=yes
add add-mac-cookie=yes address-list="" advertise=yes advertise-interval=\
    30m,10m advertise-timeout=1m advertise-url=https://ig.me/boyoz_._._ \
    idle-timeout=none insert-queue-before=first !keepalive-timeout \
    mac-cookie-timeout=7w1d name=family on-login="# ==========================\
    ====\
    \n# Hotspot Login Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :do {\
    \n        :local activeID [/ip hotspot active find mac-address=\$macaddr]\
    \n        :if ([:len \$activeID] > 0) do={\
    \n            :local activeHost [/ip hotspot active get [:pick \$activeID \
    0] host-name]\
    \n            :if ([:len \$activeHost] > 0) do={ \
    \n                :set hostname \$activeHost \
    \n            }\
    \n        }\
    \n    } on-error={}\
    \n}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n:log info (\"LOGIN - User: \$username | IP: \$ipaddr | MAC: \$macaddr | \
    Hostname: \$hostname\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\9F\A2%20HOTSPOT%20LOGIN%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGIN sent: \" . \$hostname)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGIN: \" . \$hostname)\
    \n}" on-logout="# ==============================\
    \n# Hotspot Logout Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# Ambil Traffic Usage & Konversi\
    \n# ----------------\
    \n:local bytesIn 0\
    \n:local bytesOut 0\
    \n:if ([:typeof \$\"bytes-in\"] != \"nothing\") do={ :set bytesIn \$\"byte\
    s-in\" }\
    \n:if ([:typeof \$\"bytes-out\"] != \"nothing\") do={ :set bytesOut \$\"by\
    tes-out\" }\
    \n:local totalBytes (\$bytesIn + \$bytesOut)\
    \n\
    \n# Fungsi Konversi Bytes (Sekarang menggunakan %20)\
    \n:local convertBytes do={\
    \n    :local bytes [:tonum \$1]\
    \n    :if (\$bytes = 0) do={ :return \"0%20Bytes\" }\
    \n    :if (\$bytes >= 1099511627776) do={ :local value (\$bytes / 10995116\
    27776); :return ([:tostr \$value] . \"%20TB\") }\
    \n    :if (\$bytes >= 1073741824) do={ :local value (\$bytes / 1073741824)\
    ; :return ([:tostr \$value] . \"%20GB\") }\
    \n    :if (\$bytes >= 1048576) do={ :local value (\$bytes / 1048576); :ret\
    urn ([:tostr \$value] . \"%20MB\") }\
    \n    :if (\$bytes >= 1024) do={ :local value (\$bytes / 1024); :return ([\
    :tostr \$value] . \"%20KB\") }\
    \n    :return ([:tostr \$bytes] . \"%20Bytes\")\
    \n}\
    \n\
    \n:local downloadSize [\$convertBytes \$bytesOut]\
    \n:local uploadSize [\$convertBytes \$bytesIn]\
    \n:local totalSize [\$convertBytes \$totalBytes]\
    \n\
    \n:log info (\"LOGOUT - IP: \$ipaddr | MAC: \$macaddr | Hostname: \$hostna\
    me | Traffic: \$totalSize\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\94\B4%20HOTSPOT%20LOGOUT%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"Download:%20\" . \$downloadSize . \"%0A\")\
    \n:set msg (\$msg . \"Upload:%20\" . \$uploadSize . \"%0A\")\
    \n:set msg (\$msg . \"Total:%20\" . \$totalSize . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGOUT sent: \" . \$hostname . \" | Traffic: \
    \" . \$totalSize)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGOUT: \" . \$hostname)\
    \n}" open-status-page=always parent-queue=HOTSPOT-Traffic !queue-type \
    rate-limit=10m shared-users=5 status-autorefresh=1m transparent-proxy=yes
add add-mac-cookie=no address-list="" address-pool=hs-pool-Tamu advertise=yes \
    advertise-interval=30m,10m advertise-timeout=1m advertise-url=\
    https://google.com idle-timeout=1m insert-queue-before=bottom \
    keepalive-timeout=30s !mac-cookie-timeout name=trial on-login="# =========\
    =====================\
    \n# Hotspot Login Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :do {\
    \n        :local activeID [/ip hotspot active find mac-address=\$macaddr]\
    \n        :if ([:len \$activeID] > 0) do={\
    \n            :local activeHost [/ip hotspot active get [:pick \$activeID \
    0] host-name]\
    \n            :if ([:len \$activeHost] > 0) do={ \
    \n                :set hostname \$activeHost \
    \n            }\
    \n        }\
    \n    } on-error={}\
    \n}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n:log info (\"LOGIN - User: \$username | IP: \$ipaddr | MAC: \$macaddr | \
    Hostname: \$hostname\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\9F\A2%20HOTSPOT%20LOGIN%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGIN sent: \" . \$hostname)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGIN: \" . \$hostname)\
    \n}" on-logout="# ==============================\
    \n# Hotspot Logout Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# Ambil Traffic Usage & Konversi\
    \n# ----------------\
    \n:local bytesIn 0\
    \n:local bytesOut 0\
    \n:if ([:typeof \$\"bytes-in\"] != \"nothing\") do={ :set bytesIn \$\"byte\
    s-in\" }\
    \n:if ([:typeof \$\"bytes-out\"] != \"nothing\") do={ :set bytesOut \$\"by\
    tes-out\" }\
    \n:local totalBytes (\$bytesIn + \$bytesOut)\
    \n\
    \n# Fungsi Konversi Bytes (Sekarang menggunakan %20)\
    \n:local convertBytes do={\
    \n    :local bytes [:tonum \$1]\
    \n    :if (\$bytes = 0) do={ :return \"0%20Bytes\" }\
    \n    :if (\$bytes >= 1099511627776) do={ :local value (\$bytes / 10995116\
    27776); :return ([:tostr \$value] . \"%20TB\") }\
    \n    :if (\$bytes >= 1073741824) do={ :local value (\$bytes / 1073741824)\
    ; :return ([:tostr \$value] . \"%20GB\") }\
    \n    :if (\$bytes >= 1048576) do={ :local value (\$bytes / 1048576); :ret\
    urn ([:tostr \$value] . \"%20MB\") }\
    \n    :if (\$bytes >= 1024) do={ :local value (\$bytes / 1024); :return ([\
    :tostr \$value] . \"%20KB\") }\
    \n    :return ([:tostr \$bytes] . \"%20Bytes\")\
    \n}\
    \n\
    \n:local downloadSize [\$convertBytes \$bytesOut]\
    \n:local uploadSize [\$convertBytes \$bytesIn]\
    \n:local totalSize [\$convertBytes \$totalBytes]\
    \n\
    \n:log info (\"LOGOUT - IP: \$ipaddr | MAC: \$macaddr | Hostname: \$hostna\
    me | Traffic: \$totalSize\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\94\B4%20HOTSPOT%20LOGOUT%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"Download:%20\" . \$downloadSize . \"%0A\")\
    \n:set msg (\$msg . \"Upload:%20\" . \$uploadSize . \"%0A\")\
    \n:set msg (\$msg . \"Total:%20\" . \$totalSize . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGOUT sent: \" . \$hostname . \" | Traffic: \
    \" . \$totalSize)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGOUT: \" . \$hostname)\
    \n}\
    \n" open-status-page=always parent-queue=HOTSPOT-Traffic queue-type=\
    hotspot-default rate-limit=1m/1m session-timeout=20m shared-users=2 \
    status-autorefresh=10s transparent-proxy=yes
add add-mac-cookie=no address-list="" address-pool=hs-pool-Tamu advertise=no \
    idle-timeout=5m insert-queue-before=bottom keepalive-timeout=1m \
    !mac-cookie-timeout name=teman on-login="# ==============================\
    \n# Hotspot Login Notification to Telegram\
    \n# Version : 6.4 (Fix Encoding & Fetch)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# Ambil Hostname\
    \n:local hostname \"Unknown-Device\"\
    \n:do {\
    \n    :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr]\
    \n    :if ([:len \$leaseID] > 0) do={\
    \n        :set hostname [/ip dhcp-server lease get [:pick \$leaseID 0] hos\
    t-name]\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if ([:len \$hostname] = 0) do={ :set hostname (\"Device-\" . [:pick \$m\
    acaddr 12 17]) }\
    \n\
    \n# Convert Trial\
    \n:if ([:pick \$username 0 2] = \"T-\") do={ :set username (\"Trial - \" .\
    \_\$hostname) }\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# FORMAT PESAN (Gunakan \\n untuk baris baru, bukan %0A di sini)\
    \n# ----------------\
    \n:local msgText \"\F0\9F\9F\A2 HOTSPOT LOGIN\\n==========================\
    ==\\nUser: \$username\\nHostname: \$hostname\\nIP: \$ipaddr\\nMAC: \$macad\
    dr\\nDate: \$tanggal\\nTime: \$waktu\\n============================\"\
    \n\
    \n# ----------------\
    \n# KIRIM DENGAN URL-ENCODE OTOMATIS\
    \n# ----------------\
    \n:local url \"https://api.telegram.org/bot\$botToken/sendMessage\"\
    \n:local postData \"chat_id=\$chatID&text=\$msgText\"\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=\$postData \\\
    \n        check-certificate=no \\\
    \n        timeout=10s \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGIN sent: \$hostname\")\
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGIN: \$hostname - Periksa Koneksi In\
    ternet atau Bot Token\")\
    \n}\
    \n" on-logout="# ==============================\
    \n# Hotspot Logout Notification to Telegram\
    \n# Version: 6.3 (Fix URL Encode Space)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n# ----------------\
    \n# CONVERT USERNAME TRIAL KE HOSTNAME\
    \n# ----------------\
    \n:if ([:pick \$username 0 2] = \"T-\") do={\
    \n    :set username (\"Trial - \" . \$hostname)\
    \n}\
    \n\
    \n# ----------------\
    \n# FUNGSI ENCODE SPASI (%20) AGAR TELEGRAM TIDAK ERROR\
    \n# ----------------\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n:set username [\$encodeSpace \$username]\
    \n:set hostname [\$encodeSpace \$hostname]\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# Ambil Traffic Usage & Konversi\
    \n# ----------------\
    \n:local bytesIn 0\
    \n:local bytesOut 0\
    \n:if ([:typeof \$\"bytes-in\"] != \"nothing\") do={ :set bytesIn \$\"byte\
    s-in\" }\
    \n:if ([:typeof \$\"bytes-out\"] != \"nothing\") do={ :set bytesOut \$\"by\
    tes-out\" }\
    \n:local totalBytes (\$bytesIn + \$bytesOut)\
    \n\
    \n# Fungsi Konversi Bytes (Sekarang menggunakan %20)\
    \n:local convertBytes do={\
    \n    :local bytes [:tonum \$1]\
    \n    :if (\$bytes = 0) do={ :return \"0%20Bytes\" }\
    \n    :if (\$bytes >= 1099511627776) do={ :local value (\$bytes / 10995116\
    27776); :return ([:tostr \$value] . \"%20TB\") }\
    \n    :if (\$bytes >= 1073741824) do={ :local value (\$bytes / 1073741824)\
    ; :return ([:tostr \$value] . \"%20GB\") }\
    \n    :if (\$bytes >= 1048576) do={ :local value (\$bytes / 1048576); :ret\
    urn ([:tostr \$value] . \"%20MB\") }\
    \n    :if (\$bytes >= 1024) do={ :local value (\$bytes / 1024); :return ([\
    :tostr \$value] . \"%20KB\") }\
    \n    :return ([:tostr \$bytes] . \"%20Bytes\")\
    \n}\
    \n\
    \n:local downloadSize [\$convertBytes \$bytesOut]\
    \n:local uploadSize [\$convertBytes \$bytesIn]\
    \n:local totalSize [\$convertBytes \$totalBytes]\
    \n\
    \n:log info (\"LOGOUT - IP: \$ipaddr | MAC: \$macaddr | Hostname: \$hostna\
    me | Traffic: \$totalSize\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"\F0\9F\94\B4%20HOTSPOT%20LOGOUT%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User:%20\" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname:%20\" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP%20Address:%20\" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC%20Address:%20\" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date:%20\" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time:%20\" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"Download:%20\" . \$downloadSize . \"%0A\")\
    \n:set msg (\$msg . \"Upload:%20\" . \$uploadSize . \"%0A\")\
    \n:set msg (\$msg . \"Total:%20\" . \$totalSize . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGOUT sent: \" . \$hostname . \" | Traffic: \
    \" . \$totalSize)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGOUT: \" . \$hostname)\
    \n}" open-status-page=always parent-queue=HOTSPOT-Traffic !queue-type \
    rate-limit=15m session-timeout=12h shared-users=1 status-autorefresh=1m \
    transparent-proxy=yes
/ip hotspot profile
add dns-name=gateway.linelejan-rumagit.net hotspot-address=10.10.10.1 \
    html-directory=flash/hotspotV3 html-directory-override=flash/hotspotV3 \
    http-proxy=0.0.0.0:10023 install-hotspot-queue=yes login-by=\
    http-pap,trial name=hs_tamu rate-limit="" smtp-server=0.0.0.0 \
    split-user-domain=yes trial-uptime-limit=5m trial-uptime-reset=1w \
    trial-user-profile=trial use-radius=no
/queue tree
add bucket-size=0.1 burst-limit=15M burst-threshold=5M burst-time=2m \
    disabled=no limit-at=10M max-limit=15M name="Prioritas Game" packet-mark=\
    GAME-Priority-Packet parent=ISP priority=1 queue="Game Low Latency"
add bucket-size=0.1 burst-limit=11M burst-threshold=1M burst-time=10s \
    disabled=yes limit-at=8M max-limit=10M name=TikTok packet-mark=\
    TikTok-Packet parent=global priority=8 queue=pcq-download-default
add bucket-size=0.1 burst-limit=0 burst-threshold=0 burst-time=0s disabled=no \
    limit-at=2M max-limit=2M name=queue1Tiktok packet-mark=TikTok-Packet \
    parent=global priority=8 queue=pcq-download-default
add bucket-size=0.1 burst-limit=0 burst-threshold=0 burst-time=0s disabled=no \
    limit-at=0 max-limit=10M name=VideoCall-Uplink packet-mark=\
    VideoCall_upload parent=ISP priority=1 queue=pcq-upload-default
/routing bgp template
set default name=default
/routing table
add name=rtab-1
add fib name=to-private
/snmp community
set [ find default=yes ] addresses=::/0 authentication-protocol=MD5 disabled=\
    no encryption-protocol=DES name=public read-access=yes security=none \
    write-access=no
/system keymat-provider
add disabled=yes hkdf-hash=sha256 key-size=128 name=default qkd-address="" \
    qkd-cache-size=2 qkd-certificate=none qkd-kme-id="" qkd-peer-sae-id="" \
    type=qkd
/system logging action
set 0 memory-lines=1000 memory-stop-on-full=no name=memory target=memory
set 1 disk-file-count=2 disk-file-name=flash/log disk-lines-per-file=1000 \
    disk-stop-on-full=no name=disk target=disk
set 2 name=echo remember=yes target=echo
set 3 name=remote remote=0.0.0.0 remote-log-format=default remote-port=514 \
    remote-protocol=udp src-address=0.0.0.0 target=remote vrf=main
/system script
add dont-require-permissions=no name=autoBackup1 owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local botToken \"7800813983:AAFWObgeBj8Eo7i8lgXIq2k8TVTbuAIcTTU\"\
    \n:local chatID \"1571509712\"\
    \n# Ambil data waktu dan nama file\
    \n:local tanggal [/system clock get date]\
    \n:local waktu [/system clock get time]\
    \n:local backupFileName (\$tanggal . \".backup\")\
    \n\
    \n# Ambil penggunaan data dari interface tertentu\
    \n:local iface \"ISP\"\
    \n:local rx [/interface get \$iface rx-byte]\
    \n:local tx [/interface get \$iface tx-byte]\
    \n:local total (\$rx + \$tx)\
    \n\
    \n# Format ukuran byte agar lebih manusiawi (MB/GB dsb)\
    \n:local formatBytes do={\
    \n    :local size \$1\
    \n    :if (\$size < 1024) do={ :return (\$size . \" B\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" KB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" MB\") }\
    \n    :set size (\$size / 1024)\
    \n    :return (\$size . \" GB\")\
    \n}\
    \n\
    \n:local rxNice [\$formatBytes \$rx]\
    \n:local txNice [\$formatBytes \$tx]\
    \n:local totalNice [\$formatBytes \$total]\
    \n\
    \n# Backup\
    \n/system backup save name=\$backupFileName\
    \n# Kirim Notifikasi Telegram\
    \n:local message \"Backup MikroTik berhasil dikirim ke email pada \$waktu \
    | \$tanggal | Penggunaan data ether \$iface : Download \$rxNice / Upload \
    \$txNice (Total: \$totalNice)\"\
    \n/ sys script run kirimPenggunaanData\
    \n/tool fetch url=\"https://api.telegram.org/bot\$botToken/sendMessage\?ch\
    at_id=\$chatID&text=\$message\" http-method=get keep-result=no\
    \n\
    \n:delay 2s\
    \n/tool e-mail send to=\"ryolinelejan0@gmail.com\" subject=\"Backup Router\
    \" body=\"File ini dikirim otomatis dari sistem. \$waktu | \$tanggal | Pen\
    ggunaan data \$iface: Download \$rxNice / Upload \$txNice (Total: \$totalN\
    ice)\" file=\$backupFileName\
    \n\
    \n:delay 5s\
    \n/file remove \$backupFileName\
    \n\
    \n:log info \"Notifikasi Telegram dikirim setelah backup email!\""
add dont-require-permissions=yes name=autoBackup owner=admin policy=\
    ftp,reboot,read,write,policy,test,sniff,sensitive source=":local botToken \
    \"7786422424:AAFTtm8c9NcylgJg2mVBp3QGz06iU2fxmgc\"\
    \n:local chatID \"1571509712\"\
    \n:local iface \"ISP\"\
    \n\
    \n:local tanggalAsli [/system clock get date]\
    \n:local waktu [/system clock get time]\
    \n:local uptime [/system resource get uptime]\
    \n\
    \n# 1. Ubah format tanggal (mar/17/2026 -> mar-17-2026) agar aman jadi nam\
    a file\
    \n:local tanggal \"\"\
    \n:for i from=0 to=([:len \$tanggalAsli] - 1) do={\
    \n    :local char [:pick \$tanggalAsli \$i]\
    \n    :if (\$char = \"/\") do={ :set char \"-\" }\
    \n    :set tanggal (\$tanggal . \$char)\
    \n}\
    \n\
    \n:local backupFileName (\$tanggal . \".backup\")\
    \n\
    \n# 2. Ambil data trafik dari interface\
    \n:local rx [/interface get \$iface rx-byte]\
    \n:local tx [/interface get \$iface tx-byte]\
    \n:local total (\$rx + \$tx)\
    \n\
    \n# 3. Format byte agar manusiawi (Spasi di sini dibiarkan aman untuk di E\
    mail)\
    \n:local formatBytes do={\
    \n    :local size \$1\
    \n    :if (\$size < 1024) do={ :return (\$size . \" B\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" KB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" MB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" GB\") }\
    \n    :set size (\$size / 1024)\
    \n    :return (\$size . \" TB\")\
    \n}\
    \n\
    \n:local rxNice [\$formatBytes \$rx]\
    \n:local txNice [\$formatBytes \$tx]\
    \n:local totalNice [\$formatBytes \$total]\
    \n\
    \n# 4. Fungsi URL Encode (Ubah Spasi -> %20 KHUSUS UNTUK TELEGRAM)\
    \n:local encodeSpace do={\
    \n    :local str [:tostr \$1]\
    \n    :local res \"\"\
    \n    :for i from=0 to=([:len \$str] - 1) do={\
    \n        :local char [:pick \$str \$i]\
    \n        :if (\$char = \" \") do={ :set char \"%20\" }\
    \n        :set res (\$res . \$char)\
    \n    }\
    \n    :return \$res\
    \n}\
    \n\
    \n# --- PROSES BACKUP & NOTIFIKASI MULAI --- #\
    \n\
    \n# Backup file\
    \n/system backup save name=\$backupFileName\
    \n\
    \n# Kirim via email (Beri jeda 5 detik agar file selesai dibuat sebelum di\
    kirim)\
    \n:delay 5s\
    \n/tool e-mail send to=\"ryolinelejan01@gmail.com\" subject=\"Backup Route\
    r\" body=(\"Backup otomatis sistem \$tanggalAsli \$waktu.\\nTotal Pengguna\
    an Data ether \$iface \\nDownload: \$rxNice\\nUpload: \$txNice\\nTotal: \$\
    totalNice\") file=\$backupFileName\
    \n\
    \n# Setup URL Telegram\
    \n:local urlTelegram (\"https://api.telegram.org/bot\" . \$botToken . \"/s\
    endMessage\")\
    \n\
    \n# Notifikasi Telegram: Backup sukses\
    \n:delay 2s\
    \n:local msg1 (\"[Backup MikroTik]%0AStatus: Sukses Dikirim ke Email%0ATan\
    ggal: \$tanggalAsli%0AWaktu: \$waktu%0AUptime: \$uptime\")\
    \n:set msg1 [\$encodeSpace \$msg1]\
    \n/tool fetch url=\$urlTelegram http-method=post http-data=(\"chat_id=\" .\
    \_\$chatID . \"&text=\" . \$msg1) keep-result=no\
    \n\
    \n# Notifikasi Telegram: Penggunaan data\
    \n:delay 2s\
    \n:local msg2 (\"[Penggunaan Data ether \$iface]%0AInterface: \$iface%0ATa\
    nggal/Waktu: \$tanggalAsli \$waktu%0ADownload: \$rxNice%0AUpload: \$txNice\
    %0ATotal: \$totalNice%0AUptime: \$uptime\")\
    \n:set msg2 [\$encodeSpace \$msg2]\
    \n/tool fetch url=\$urlTelegram http-method=post http-data=(\"chat_id=\" .\
    \_\$chatID . \"&text=\" . \$msg2) keep-result=no\
    \n\
    \n# Hapus file backup dari penyimpanan MikroTik\
    \n:delay 10s\
    \n/file remove \$backupFileName\
    \n\
    \n:log info \"Backup, email, dan notifikasi Telegram selesai dikirim.\"\
    \n"
add dont-require-permissions=no name=kirimPenggunaanData owner=admin policy=\
    read,write,policy,test,password,sniff,sensitive source=":local botToken \"\
    7970829466:AAGK0XhAHOBwrJcoLEl8jU9Dml6y8H6zXiI\"\
    \n:local chatID \"1571509712\"\
    \n:local iface \"ISP\"\
    \n\
    \n:local tanggal [/system clock get date]\
    \n:local waktu [/system clock get time]\
    \n:local rx [/interface get \$iface rx-byte]\
    \n:local tx [/interface get \$iface tx-byte]\
    \n:local total (\$rx + \$tx)\
    \n\
    \n:local formatBytes do={\
    \n    :local size \$1\
    \n    :if (\$size < 1024) do={ :return (\$size . \" B\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" KB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" MB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" GB\") }\
    \n    :set size (\$size / 1024)\
    \n    :return (\$size . \" TB\")\
    \n}\
    \n\
    \n:local rxNice [\$formatBytes \$rx]\
    \n:local txNice [\$formatBytes \$tx]\
    \n:local totalNice [\$formatBytes \$total]\
    \n\
    \n:local msg (\"[Penggunaan Data Interface \$iface]%0A\" . \\\
    \n            \"Tanggal: \$tanggal%0A\" . \\\
    \n            \"Download: \$rxNice - \" . \\\
    \n            \"Upload: \$txNice%0A\" . \\\
    \n            \"Total: \$totalNice\")\
    \n\
    \n/tool fetch url=(\"https://api.telegram.org/bot\" . \$botToken . \\\
    \n\"/sendMessage\?chat_id=\" . \$chatID . \"&text=\" . \$msg) http-method=\
    get keep-result=no\
    \n\
    \n:log info \"Notifikasi Telegram penggunaan data berhasil dikirim!\""
add dont-require-permissions=yes name=kirimInfoPenggunaWifi owner=admin \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source="# ===============================================================\
    \n# Script: Notifikasi Perangkat Baru ke Telegram (Diperbaiki)\
    \n# Dibuat untuk: MikroTik RouterOS\
    \n# ===============================================================\
    \n\
    \n# Variabel Global untuk Bot dan Chat ID Telegram\
    \n:local botApi \"7800813983:AAFWObgeBj8Eo7i8lgXIq2k8TVTbuAIcTTU\";\
    \n:local chatId \"1571509712\";\
    \n\
    \n# Variabel yang didapat dari DHCP Lease Script\
    \n:local macAddress \$\"leaseActMAC\";\
    \n:local ipAddress \$\"leaseActIP\";\
    \n:local deviceName \$\"lease-hostname\";\
    \n\
    \n# Jika nama perangkat tidak ada, gunakan IP sebagai nama\
    \n:if ([:len \$deviceName] = 0) do={\
    \n  :set deviceName \$ipAddress;\
    \n}\
    \n\
    \n# Beri jeda 1 detik agar MAC address sempat terdaftar\
    \n:delay 1s;\
    \n\
    \n# Mencari interface tempat perangkat terhubung dengan lebih aman\
    \n:local interfaceName \"N/A\";\
    \n\
    \n# Cek dulu di tabel Bridge Host\
    \n:local foundInBridge [/interface bridge host find where mac-address=\$ma\
    cAddress];\
    \nif ([:len \$foundInBridge] > 0) do={\
    \n    :set interfaceName [/interface bridge host get \$foundInBridge on-in\
    terface];\
    \n} else={\
    \n    # Jika tidak ada, cek di tabel ARP\
    \n    :local foundInArp [/ip arp find where mac-address=\$macAddress];\
    \n    if ([:len \$foundInArp] > 0) do={\
    \n        :set interfaceName [/ip arp get \$foundInArp interface];\
    \n    }\
    \n}\
    \n\
    \n# Format Pesan Notifikasi\
    \n:local message \"\E2\9C\85 *Perangkat Baru Terhubung*%0A%0A*Nama*: `\$de\
    viceName`%0A*MAC*: `\$macAddress`%0A*IP*: `\$ipAddress`%0A*Interface*: `\$\
    interfaceName`\";\
    \n\
    \n# URL untuk mengirim pesan ke API Telegram\
    \n:local url \"https://api.telegram.org/bot\$botApi/sendMessage\?chat_id=\
    \$chatId&text=\$message&parse_mode=Markdown\";\
    \n\
    \n# Mengirim notifikasi menggunakan tool fetch\
    \n/tool fetch url=\$url keep-result=no;\
    \n"
add dont-require-permissions=yes name=notif-logout owner=admin policy=\
    read,write,policy,test,password,sniff,sensitive,romon source="# ==========\
    ====================\
    \n# Hotspot Logout Notification to Telegram\
    \n# Version: 6.1 (Fixed Swapped Traffic)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n# ----------------\
    \n# Ambil Traffic Usage\
    \n# ----------------\
    \n:local bytesIn 0\
    \n:local bytesOut 0\
    \n:if ([:typeof \$\"bytes-in\"] != \"nothing\") do={ \
    \n    :set bytesIn \$\"bytes-in\" \
    \n}\
    \n:if ([:typeof \$\"bytes-out\"] != \"nothing\") do={ \
    \n    :set bytesOut \$\"bytes-out\" \
    \n}\
    \n:local totalBytes (\$bytesIn + \$bytesOut)\
    \n\
    \n:log info (\"LOGOUT - IP: \$ipaddr | MAC: \$macaddr | Hostname: \$hostna\
    me | Down: \$bytesOut | Up: \$bytesIn\")\
    \n\
    \n# ----------------\
    \n# Fungsi Konversi Bytes (Ini sudah benar)\
    \n# ----------------\
    \n:local convertBytes do={\
    \n    :local bytes [:tonum \$1]\
    \n    :if (\$bytes = 0) do={ :return \"0 Bytes\" }\
    \n    :if (\$bytes >= 1099511627776) do={ :local value (\$bytes / 10995116\
    27776); :return ([:tostr \$value] . \" TB\") }\
    \n    :if (\$bytes >= 1073741824) do={ :local value (\$bytes / 1073741824)\
    ; :return ([:tostr \$value] . \" GB\") }\
    \n    :if (\$bytes >= 1048576) do={ :local value (\$bytes / 1048576); :ret\
    urn ([:tostr \$value] . \" MB\") }\
    \n    :if (\$bytes >= 1024) do={ :local value (\$bytes / 1024); :return ([\
    :tostr \$value] . \" KB\") }\
    \n    :return ([:tostr \$bytes] . \" Bytes\")\
    \n}\
    \n\
    \n# <--- PERBAIKAN DI SINI\
    \n# bytesOut adalah Download (data ke klien)\
    \n# bytesIn adalah Upload (data dari klien)\
    \n:local downloadSize [\$convertBytes \$bytesOut]\
    \n:local uploadSize [\$convertBytes \$bytesIn]\
    \n# <--- AKHIR PERBAIKAN\
    \n:local totalSize [\$convertBytes \$totalBytes]\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"HOTSPOT LOGOUT%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"User: \" . \$username . \"%0A\")\
    \n:set msg (\$msg . \"Hostname: \" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP Address: \" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC Address: \" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date: \" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time: \" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================%0A\")\
    \n:set msg (\$msg . \"Download: \" . \$downloadSize . \"%0A\")\
    \n:set msg (\$msg . \"Upload: \" . \$uploadSize . \"%0A\")\
    \n:set msg (\$msg . \"Total: \" . \$totalSize . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGOUT sent: \" . \$hostname . \" | Traffic: \
    \" . \$totalSize)\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGOUT: \" . \$hostname)\
    \n}"
add dont-require-permissions=yes name=reset-login-count owner=admin policy=\
    read,write,policy,test,password,sniff,sensitive,romon source="# Nama scrip\
    t: reset-login-count\
    \n/ip dhcp-server lease\
    \n:foreach lease in=[find] do={\
    \n    :if ([get \$lease comment] != \"\") do={\
    \n        set \$lease comment=\"\"\
    \n    }\
    \n}\
    \n/ip hotspot ip-binding\
    \n:foreach binding in=[find where type=blocked comment~\"Blocked until mid\
    night\"] do={\
    \n    remove \$binding\
    \n}\
    \n:log info \"Login counts and blocks reset at midnight\""
add dont-require-permissions=no name="test debug " owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global username \"testuser\"\
    \n:global mac \"00:11:22:33:44:55\"\
    \n:global ip \"192.168.1.100\"\
    \n:global interface \"wlan1\"\
    \n"
add dont-require-permissions=no name=duckdns_update owner=admin policy=\
    read,write,test,sniff source=":local token \"e1308a98-d30a-43c5-8e95-3db63\
    966727d\";\
    \n:local domain \"gateway-ryo.duckdns.org\";\
    \n:local url \"https://www.duckdns.org/update\?domains=\$domain&token=\$to\
    ken&ip=\";\
    \n/tool fetch url=\$url keep-result=no"
add dont-require-permissions=no name=restore-config owner=admin policy=\
    reboot,write,policy source=\
    "/system/backup/load name=2025-09-24.backup password="
add dont-require-permissions=yes name=notif-login owner=admin policy=\
    read,write,policy,test,password,sniff,sensitive,romon source="# ==========\
    ====================\
    \n# Hotspot Login Notification to Telegram\
    \n# Version: 6.0 (Added Hotspot User)\
    \n# ==============================\
    \n\
    \n:local botToken \"8284308676:AAHPoP-Quw7T-81Izr5aJBC3MN2RhUCoceU\"\
    \n:local chatID \"1571509712\"\
    \n\
    \n:local username \$user\
    \n:local ipaddr \$address\
    \n:local macaddr \$\"mac-address\"\
    \n\
    \n:if ([:typeof \$username] = \"nothing\") do={ :set username \"Unknown\" \
    }\
    \n:if ([:typeof \$ipaddr] = \"nothing\") do={ :set ipaddr \"0.0.0.0\" }\
    \n:if ([:typeof \$macaddr] = \"nothing\") do={ :set macaddr \"00:00:00:00:\
    00:00\" }\
    \n\
    \n# ----------------\
    \n# Ambil Device Hostname\
    \n# ----------------\
    \n:local hostname \"Unknown-Device\"\
    \n\
    \n:do {\
    \n    :if (\$macaddr != \"00:00:00:00:00:00\") do={\
    \n        :local leaseID [/ip dhcp-server lease find mac-address=\$macaddr\
    ]\
    \n        :if ([:len \$leaseID] > 0) do={\
    \n            :local dhcpHostname [/ip dhcp-server lease get [:pick \$leas\
    eID 0] host-name]\
    \n            :if ([:len \$dhcpHostname] > 0) do={\
    \n                :set hostname \$dhcpHostname\
    \n            }\
    \n        }\
    \n    }\
    \n} on-error={}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :do {\
    \n        :local activeID [/ip hotspot active find mac-address=\$macaddr]\
    \n        :if ([:len \$activeID] > 0) do={\
    \n            :local activeHost [/ip hotspot active get [:pick \$activeID \
    0] host-name]\
    \n            :if ([:len \$activeHost] > 0) do={ \
    \n                :set hostname \$activeHost \
    \n            }\
    \n        }\
    \n    } on-error={}\
    \n}\
    \n\
    \n:if (\$hostname = \"Unknown-Device\" || \$hostname = \"\" || [:len \$hos\
    tname] = 0) do={\
    \n    :set hostname (\"Device-\" . [:pick \$macaddr 12 17])\
    \n}\
    \n\
    \n:local waktu [/system clock get time]\
    \n:local tanggal [/system clock get date]\
    \n\
    \n:log info (\"LOGIN - User: \$username | IP: \$ipaddr | MAC: \$macaddr | \
    Hostname: \$hostname\")\
    \n\
    \n# ----------------\
    \n# Format & Kirim Pesan\
    \n# ----------------\
    \n:local msg \"HOTSPOT LOGIN%0A\"\
    \n:set msg (\$msg . \"============================%0A\")\
    \n# <--- TAMBAHAN DI SINI\
    \n:set msg (\$msg . \"User: \" . \$username . \"%0A\")\
    \n# <--- AKHIR TAMBAHAN\
    \n:set msg (\$msg . \"Hostname: \" . \$hostname . \"%0A\")\
    \n:set msg (\$msg . \"IP Address: \" . \$ipaddr . \"%0A\")\
    \n:set msg (\$msg . \"MAC Address: \" . \$macaddr . \"%0A\")\
    \n:set msg (\$msg . \"Date: \" . \$tanggal . \"%0A\")\
    \n:set msg (\$msg . \"Time: \" . \$waktu . \"%0A\")\
    \n:set msg (\$msg . \"============================\")\
    \n\
    \n:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessa\
    ge\")\
    \n\
    \n:do {\
    \n    /tool fetch url=\$url \\\
    \n        http-method=post \\\
    \n        http-data=(\"chat_id=\" . \$chatID . \"&text=\" . \$msg) \\\
    \n        mode=https \\\
    \n        keep-result=no\
    \n    \
    \n    :log info (\"Telegram LOGIN sent: \" . \$hostname . \" (\" . \$ipadd\
    r . \")\")\
    \n    \
    \n} on-error={\
    \n    :log error (\"Failed Telegram LOGIN: \" . \$hostname)\
    \n}\
    \n"
add dont-require-permissions=yes name=script1Hotspot owner=admin policy=\
    read,write,policy,test,sniff,sensitive,romon source=":local user \$\"user\
    \"\
    \n:local ip \$\"address\"\
    \n:local mac \$\"mac\"\
    \n:local uptime \$\"uptime\"\
    \n:local bytesin \$\"bytes-in\"\
    \n:local bytesout \$\"bytes-out\"\
    \n\
    \n/log info \"===== TEST HOTSPOT VARIABEL =====\"\
    \n/log info (\"User: \$user\")\
    \n/log info (\"IP: \$ip\")\
    \n/log info (\"MAC: \$mac\")\
    \n/log info (\"Uptime: \$uptime\")\
    \n/log info (\"Bytes In: \$bytesin\")\
    \n/log info (\"Bytes Out: \$bytesout\")\
    \n/log info \"================================\""
add dont-require-permissions=yes name="script uptime " owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local botToken \"7800813983:AAFWObgeBj8Eo7i8lgXIq2k8TVTbuAIcTTU\"\
    \n:local chatID \"1571509712\"\
    \n:local iface \"ISP\"\
    \n\
    \n:local tanggal [/system clock get date]\
    \n:local waktu [/system clock get time]\
    \n:local uptime [/system resource get uptime]\
    \n\
    \n:local backupFileName (\$tanggal . \".backup\")\
    \n\
    \n# Ambil data trafik dari interface\
    \n:local rx [/interface get \$iface rx-byte]\
    \n:local tx [/interface get \$iface tx-byte]\
    \n:local total (\$rx + \$tx)\
    \n\
    \n# Format byte agar manusiawi\
    \n:local formatBytes do={\
    \n    :local size \$1\
    \n    :if (\$size < 1024) do={ :return (\$size . \" B\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" KB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" MB\") }\
    \n    :set size (\$size / 1024)\
    \n    :if (\$size < 1024) do={ :return (\$size . \" GB\") }\
    \n    :set size (\$size / 1024)\
    \n    :return (\$size . \" TB\")\
    \n}\
    \n\
    \n:local rxNice [\$formatBytes \$rx]\
    \n:local txNice [\$formatBytes \$tx]\
    \n:local totalNice [\$formatBytes \$total]\
    \n\
    \n# Backup file\
    \n/system backup save name=\$backupFileName\
    \n\
    \n# Kirim via email\
    \n:delay 1s\
    \n/tool e-mail send to=\"ryolinelejan01@gmail.com\" subject=\"Backup Route\
    r\" body=(\"Backup otomatis sistem \$tanggal \$waktu.\\nTotal Penggunaan D\
    ata ether \$iface \\nDownload: \$rxNice\\nUpload: \$txNice\\nTotal: \$tota\
    lNice\") file=\$backupFileName\
    \n\
    \n# Notifikasi Telegram: Backup sukses\
    \n:delay 1s\
    \n:local msg1 (\"[Backup MikroTik]%0AStatus: Sukses Dikirim ke Email%0ATan\
    ggal: \$tanggal%0AWaktu: \$waktu%0AUptime: \$uptime\")\
    \n/tool fetch url=(\"https://api.telegram.org/bot\" . \$botToken . \"/send\
    Message\?chat_id=\" . \$chatID . \"&text=\" . \$msg1) http-method=get keep\
    -result=no\
    \n\
    \n# Notifikasi Telegram: Penggunaan data\
    \n:local msg2 (\"[Penggunaan Data ether \$iface]%0AInterface: \$iface%0ATa\
    nggal/Waktu: \$tanggal \$waktu%0ADownload: \$rxNice%0AUpload: \$txNice%0AT\
    otal: \$totalNice%0AUptime: \$uptime\")\
    \n/tool fetch url=(\"https://api.telegram.org/bot\" . \$botToken . \"/send\
    Message\?chat_id=\" . \$chatID . \"&text=\" . \$msg2) http-method=get keep\
    -result=no\
    \n\
    \n# Hapus file backup\
    \n:delay 5s\
    \n/file remove \$backupFileName\
    \n\
    \n:log info \"Backup, email, dan notifikasi Telegram selesai dikirim.\""
/tool traffic-generator raw-packet-template
add compute-checksum-from-offset=no-checksum data=random data-byte=0 header=\
    "" ip-header-offset="" ipv6-header-offset="" name=packet-template1 !port \
    random-byte-offsets-and-masks="" random-ranges="" special-footer=no \
    tcp-header-offset="" udp-compute-checksum="" udp-header-offset=""
/user group
set read name=read policy="local,telnet,ssh,reboot,read,test,winbox,password,w\
    eb,sniff,sensitive,api,romon,rest-api,!ftp,!write,!policy" skin=default
set write name=write policy="local,telnet,ssh,reboot,read,write,test,winbox,pa\
    ssword,web,sniff,sensitive,api,romon,rest-api,!ftp,!policy" skin=default
set full name=full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,\
    winbox,password,web,sniff,sensitive,api,romon,rest-api" skin=default
add name=Limited policy="local,telnet,ssh,read,write,winbox,sensitive,!ftp,!re\
    boot,!policy,!test,!password,!web,!sniff,!api,!romon,!rest-api" skin=\
    default
/user-manager attribute
set [ find default-name=Framed-IP-Address ] name=Framed-IP-Address \
    packet-types=access-accept type-id=8 value-type=ip-address vendor-id=\
    standard
set [ find default-name=Framed-IP-Netmask ] name=Framed-IP-Netmask \
    packet-types=access-accept type-id=9 value-type=ip-address vendor-id=\
    standard
set [ find default-name=Session-Timeout ] name=Session-Timeout packet-types=\
    access-accept type-id=27 value-type=uint32 vendor-id=standard
set [ find default-name=Idle-Timeout ] name=Idle-Timeout packet-types=\
    access-accept type-id=28 value-type=uint32 vendor-id=standard
set [ find default-name=Framed-Pool ] name=Framed-Pool packet-types=\
    access-accept type-id=88 value-type=string vendor-id=standard
set [ find default-name=Framed-IPv6-Address ] name=Framed-IPv6-Address \
    packet-types=access-accept type-id=168 value-type=ip-address vendor-id=\
    standard
set [ find default-name=Framed-IPv6-Pool ] name=Framed-IPv6-Pool \
    packet-types=access-accept type-id=100 value-type=string vendor-id=\
    standard
set [ find default-name=Framed-IPv6-Prefix ] name=Framed-IPv6-Prefix \
    packet-types=access-accept type-id=97 value-type=ip6-prefix vendor-id=\
    standard
set [ find default-name=Delegated-IPv6-Prefix ] name=Delegated-IPv6-Prefix \
    packet-types=access-accept type-id=123 value-type=ip6-prefix vendor-id=\
    standard
set [ find default-name=Tunnel-Type ] name=Tunnel-Type packet-types=\
    access-accept type-id=64 value-type=uint32 vendor-id=standard
set [ find default-name=Tunnel-Medium-Type ] name=Tunnel-Medium-Type \
    packet-types=access-accept type-id=65 value-type=uint32 vendor-id=\
    standard
set [ find default-name=Tunnel-Private-Group-ID ] name=\
    Tunnel-Private-Group-ID packet-types=access-accept type-id=81 value-type=\
    string vendor-id=standard
set [ find default-name=Acct-Interim-Interval ] name=Acct-Interim-Interval \
    packet-types=access-accept type-id=85 value-type=uint32 vendor-id=\
    standard
set [ find default-name=Mikrotik-Recv-Limit ] name=Mikrotik-Recv-Limit \
    packet-types=access-accept type-id=1 value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Xmit-Limit ] name=Mikrotik-Xmit-Limit \
    packet-types=access-accept type-id=2 value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Group ] name=Mikrotik-Group packet-types=\
    access-accept type-id=3 value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-Forward ] name=\
    Mikrotik-Wireless-Forward packet-types=access-accept type-id=4 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name="Mikrotik-Wireless-Skip-Dot1x " ] name=\
    "Mikrotik-Wireless-Skip-Dot1x " packet-types=access-accept type-id=5 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-Enc-Algo ] name=\
    Mikrotik-Wireless-Enc-Algo packet-types=access-accept type-id=6 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-Enc-Key ] name=\
    Mikrotik-Wireless-Enc-Key packet-types=access-accept type-id=7 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Rate-Limit ] name=Mikrotik-Rate-Limit \
    packet-types=access-accept type-id=8 value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Realm ] name=Mikrotik-Realm packet-types=\
    access-accept type-id=9 value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Host-IP ] name=Mikrotik-Host-IP \
    packet-types=access-accept type-id=10 value-type=ip-address vendor-id=\
    Mikrotik
set [ find default-name=Mikrotik-Mark-Id ] name=Mikrotik-Mark-Id \
    packet-types=access-accept type-id=11 value-type=string vendor-id=\
    Mikrotik
set [ find default-name=Mikrotik-Advertise-URL ] name=Mikrotik-Advertise-URL \
    packet-types=access-accept type-id=12 value-type=string vendor-id=\
    Mikrotik
set [ find default-name=Mikrotik-Advertise-Interval ] name=\
    Mikrotik-Advertise-Interval packet-types=access-accept type-id=13 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Recv-Limit-Gigawords ] name=\
    Mikrotik-Recv-Limit-Gigawords packet-types=access-accept type-id=14 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Xmit-Limit-Gigawords ] name=\
    Mikrotik-Xmit-Limit-Gigawords packet-types=access-accept type-id=15 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-PSK ] name=Mikrotik-Wireless-PSK \
    packet-types=access-accept type-id=16 value-type=string vendor-id=\
    Mikrotik
set [ find default-name=Mikrotik-Total-Limit ] name=Mikrotik-Total-Limit \
    packet-types=access-accept type-id=17 value-type=uint32 vendor-id=\
    Mikrotik
set [ find default-name=Mikrotik-Total-Limit-Gigawords ] name=\
    Mikrotik-Total-Limit-Gigawords packet-types=access-accept type-id=18 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Address-List ] name=Mikrotik-Address-List \
    packet-types=access-accept type-id=19 value-type=string vendor-id=\
    Mikrotik
set [ find default-name=Mikrotik-Wireless-MPKey ] name=\
    Mikrotik-Wireless-MPKey packet-types=access-accept type-id=20 value-type=\
    string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-Comment ] name=\
    Mikrotik-Wireless-Comment packet-types=access-accept type-id=21 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Delegated-IPv6-Pool ] name=\
    Mikrotik-Delegated-IPv6-Pool packet-types=access-accept type-id=22 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-DHCP-Option-Set ] name=\
    Mikrotik-DHCP-Option-Set packet-types=access-accept type-id=23 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-DHCP-Option-Param-STR1 ] name=\
    Mikrotik-DHCP-Option-Param-STR1 packet-types=access-accept type-id=24 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-DHCP-Option-Param-STR2 ] name=\
    Mikrotik-DHCP-Option-Param-STR2 packet-types=access-accept type-id=25 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-VLANID ] name=\
    Mikrotik-Wireless-VLANID packet-types=access-accept type-id=26 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-VLANIDtype ] name=\
    Mikrotik-Wireless-VLANIDtype packet-types=access-accept type-id=27 \
    value-type=uint32 vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-Minsignal ] name=\
    Mikrotik-Wireless-Minsignal packet-types=access-accept type-id=28 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Wireless-Maxsignal ] name=\
    Mikrotik-Wireless-Maxsignal packet-types=access-accept type-id=29 \
    value-type=string vendor-id=Mikrotik
set [ find default-name=Mikrotik-Switching-Filter ] name=\
    Mikrotik-Switching-Filter packet-types=access-accept type-id=30 \
    value-type=string vendor-id=Mikrotik
/user-manager user group
set [ find default-name=default ] attributes="" inner-auths=\
    ttls-pap,ttls-chap,ttls-mschap1,ttls-mschap2,peap-mschap2 name=default \
    outer-auths=\
    pap,chap,mschap1,mschap2,eap-tls,eap-ttls,eap-peap,eap-mschap2
set [ find default-name=default-anonymous ] attributes="" inner-auths="" \
    name=default-anonymous outer-auths=eap-ttls,eap-peap
/caps-man aaa
set called-format=mac:ssid interim-update=disabled mac-caching=disabled \
    mac-format=XX:XX:XX:XX:XX:XX mac-mode=as-username
/interface bridge
add ageing-time=5m arp=enabled arp-timeout=5s auto-mac=yes \
    !dhcp-agent-circuit-id !dhcp-agent-remote-id dhcp-snooping=yes \
    !dhcpv6-agent-circuit-id !dhcpv6-agent-remote-id dhcpv6-snooping=no \
    disabled=no fast-forward=yes forward-delay=15s igmp-snooping=no \
    max-learned-entries=auto max-message-age=20s mlag-heartbeat=5s \
    mlag-peer-port=none mlag-priority=128 mtu=auto name=bridge-private \
    port-cost-mode=long priority=0x8000 protocol-mode=rstp ra-guard=no \
    transmit-hold-count=6 vlan-filtering=no
/interface wireless
add area="" arp=enabled arp-timeout=auto bridge-mode=enabled \
    default-ap-tx-limit=0 default-authentication=yes default-client-tx-limit=\
    0 default-forwarding=yes disable-running-check=no disabled=no hide-ssid=\
    yes interworking-profile=disabled keepalive-frames=enabled l2mtu=1600 \
    mac-address=DE:2C:6E:3C:83:5D master-interface=wlan1-HOTSPOT \
    max-station-count=2007 mode=ap-bridge mtu=1500 multicast-buffering=\
    enabled multicast-helper=default name=IoT security-profile=IoT ssid=IoT \
    station-bridge-clone-mac=00:00:00:00:00:00 station-roaming=disabled \
    update-stats-interval=disabled vlan-id=1 vlan-mode=no-tag wds-cost-range=\
    50-150 wds-default-bridge=bridge-private wds-default-cost=100 \
    wds-ignore-ssid=no wds-mode=disabled wmm-support=disabled wps-mode=\
    disabled
/queue interface
set IoT queue=wireless-default
set bridge-private queue=no-queue
/caps-man manager
set ca-certificate=none certificate=none enabled=no package-path="" \
    require-peer-certificate=no upgrade-policy=none
/caps-man manager interface
set [ find default=yes ] disabled=no forbid=no interface=all
/certificate settings
set builtin-trust-store=default crl-download=no crl-store=ram crl-use=no
/console settings
set log-script-errors=yes sanitize-names=no tab-width=4
/disk settings
set auto-media-interface=bridge-private auto-media-sharing=no \
    auto-smb-sharing=no auto-smb-user=ryo default-mount-point-template=\
    "[slot]"
/ip smb
set comment=MikrotikSMB domain=MSHOME enabled=yes interfaces=all
/interface bridge port
add auto-isolate=no bpdu-guard=no bridge=bridge-private broadcast-flood=yes \
    disabled=no edge=yes fast-leave=no frame-types=admit-all horizon=none hw=\
    yes ingress-filtering=yes interface=ether2-PRIVATE-TV !internal-path-cost \
    learn=yes multicast-router=temporary-query mvrp-applicant-state=\
    normal-participant mvrp-registrar-state=normal !path-cost point-to-point=\
    yes priority=0x80 pvid=1 restricted-role=no restricted-tcn=no \
    tag-stacking=no trusted=yes trusted-dhcpv6=no trusted-ra=no \
    unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bpdu-guard=no bridge=bridge-private broadcast-flood=no \
    disabled=no edge=auto fast-leave=no frame-types=admit-all horizon=none \
    hw=yes ingress-filtering=yes interface="ether5-PRIVATE-Wireless " \
    !internal-path-cost learn=auto multicast-router=permanent \
    mvrp-applicant-state=normal-participant mvrp-registrar-state=normal \
    !path-cost point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no tag-stacking=no trusted=yes trusted-dhcpv6=no \
    trusted-ra=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bpdu-guard=no bridge=bridge-private broadcast-flood=yes \
    disabled=no edge=auto fast-leave=no frame-types=admit-all horizon=none \
    ingress-filtering=yes interface=i !internal-path-cost learn=auto \
    multicast-router=disabled mvrp-applicant-state=normal-participant \
    mvrp-registrar-state=normal !path-cost point-to-point=auto priority=0x80 \
    pvid=1 restricted-role=no restricted-tcn=no tag-stacking=no trusted=no \
    trusted-dhcpv6=no trusted-ra=no unknown-multicast-flood=yes \
    unknown-unicast-flood=yes
/interface bridge settings
set allow-fast-path=yes use-ip-firewall=no use-ip-firewall-for-pppoe=no \
    use-ip-firewall-for-vlan=no
/ip firewall connection tracking
set enabled=auto generic-timeout=10m icmp-timeout=10s liberal-tcp-tracking=no \
    loose-tcp-tracking=yes tcp-close-timeout=10s tcp-close-wait-timeout=10s \
    tcp-established-timeout=1d tcp-fin-wait-timeout=10s tcp-last-ack-timeout=\
    10s tcp-max-retrans-timeout=5m tcp-syn-received-timeout=5s \
    tcp-syn-sent-timeout=5s tcp-time-wait-timeout=10s tcp-unacked-timeout=5m \
    udp-stream-timeout=3m udp-timeout=10s
/ip neighbor discovery-settings
set add-dns-entries=no add-dns-entries-suffix=lan discover-interface-list=LAN \
    discover-interval=30s dying-gasp=no lldp-mac-phy-config=no \
    lldp-max-frame-size=no lldp-med=yes lldp-med-net-policy-vlan=1 \
    lldp-poe-power=yes lldp-vlan-info=no mode=tx-and-rx protocol=\
    cdp,lldp,mndp
/ip settings
set accept-redirects=yes accept-source-route=yes allow-fast-path=yes \
    arp-timeout=30s icmp-errors-use-inbound-interface-address=no \
    icmp-rate-limit=10 icmp-rate-mask=0x1818 ip-forward=yes \
    ipv4-fragment-time=3 ipv4-high-fragment-thresh=512.0KiB \
    ipv4-multipath-hash-policy=l3 max-neighbor-entries=2048 rp-filter=no \
    secure-redirects=yes send-redirects=yes tcp-syncookies=no tcp-timestamps=\
    random-offset
/ipv6 settings
set accept-redirects=yes-if-forwarding-disabled accept-router-advertisements=\
    yes accept-router-advertisements-on=static allow-fast-path=yes \
    disable-ipv6=no disable-link-local-address=yes forward=yes \
    max-neighbor-entries=1024 min-neighbor-entries=256 multipath-hash-policy=\
    l3 soft-max-neighbor-entries=512 stale-neighbor-detect-interval=30 \
    stale-neighbor-timeout=60
/interface detect-internet
set detect-interface-list=all internet-interface-list=none \
    lan-interface-list=none request-interval=2m wan-interface-list=none
/interface ethernet switch vlan
add disabled=no ports=ether2-PRIVATE-TV,ether3-LAN,ether4-PPPOE switch=\
    switchVLAN vlan-id=100
/interface l2tp-server server
set accept-proto-version=all accept-pseudowire-type=all allow-fast-path=no \
    authentication=pap,chap,mschap1,mschap2 caller-id-type=ip-address \
    default-profile=default-encryption enabled=no keepalive-timeout=30 \
    l2tpv3-circuit-id="" l2tpv3-cookie-length=0 l2tpv3-digest-hash=md5 \
    !l2tpv3-ether-interface-list max-mru=1450 max-mtu=1450 max-sessions=\
    unlimited mrru=disabled one-session-per-host=no use-ipsec=yes
/interface list member
add disabled=no interface=*8 list=Local
add disabled=no interface=*8 list=LAN
add disabled=no interface=*8 list=list-_local_only
add disabled=no interface="ether5-PRIVATE-Wireless " list=list-_local_only
add disabled=no interface=wlan1-HOTSPOT list=list_public
add disabled=no interface=ISP list=list_public
add disabled=no interface=*8 list=list-ttl1
add disabled=no interface="ether5-PRIVATE-Wireless " list=list-ttl1
add disabled=no interface=*13 list=list-ttl1
add disabled=no interface=ether4-PPPOE list=list-ttl1
add disabled=no interface=ISP list=WAN
add disabled=no interface=bridge-private list=LAN
add comment="LAN ether3" disabled=no interface=ether3-LAN list=LAN
/interface lte settings
set esim-channel=auto firmware-path=firmware link-recovery-timer=120 mode=\
    auto
/interface ovpn-server server
add auth=sha1,md5,sha256,sha512 certificate=*64 cipher=blowfish128,aes128-cbc \
    default-profile=ryoo disabled=no enable-tun-ipv6=no ipv6-prefix-len=64 \
    keepalive-timeout=60 mac-address=FE:C6:A5:8C:19:04 max-mtu=1500 mode=ip \
    name=ovpn-server1 netmask=24 port=1194 protocol=udp push-routes="" \
    push-routes-ipv6="" redirect-gateway=disabled reneg-sec=3600 \
    require-client-certificate=no tls-version=any tun-server-ipv6=:: \
    user-auth-method=pap vrf=main
/interface pppoe-server server
add accept-untagged=yes authentication=pap,chap,mschap1,mschap2 \
    default-profile=default-encryption disabled=no interface=ether4-PPPOE \
    keepalive-timeout=10 max-mru=auto max-mtu=auto max-sessions=unlimited \
    mrru=disabled one-session-per-host=yes pado-delay=0 \
    pppoe-over-vlan-range="" service-name=PPPOE-Sharing
/interface pptp-server server
# PPTP connections are considered unsafe, it is suggested to use a more modern VPN protocol instead
set authentication=mschap1,mschap2 default-profile=ryoo enabled=yes \
    keepalive-timeout=30 max-mru=1450 max-mtu=1450 mrru=disabled
/interface sstp-server server
set authentication=pap,chap,mschap1,mschap2 certificate=none ciphers=\
    aes256-sha,aes256-gcm-sha384 default-profile=default enabled=no \
    keepalive-timeout=60 max-mru=1500 max-mtu=1500 mrru=disabled pfs=no port=\
    443 tls-version=any verify-client-certificate=no
/interface wifi cap
set enabled=no
/interface wifi capsman
set enabled=no
/interface wireguard peers
add allowed-address=10.10.10.2/32 client-allowed-address="" client-endpoint=\
    "" disabled=no endpoint-address="" endpoint-port=0 interface=*E name=\
    Android public-key="HJr9Y4Ne3BBjpmXH46mU9e8WvSyrJkAj9JwBjNVXeXE="
/interface wireless access-list
add allow-signal-out-of-range=10s ap-tx-limit=0 authentication=yes \
    client-tx-limit=0 comment="Samsung A02" disabled=no forwarding=yes \
    interface=*B mac-address=DA:AE:45:96:FE:13 private-algo=none \
    signal-range=-120..120 !time vlan-id=1 vlan-mode=default
add allow-signal-out-of-range=10s ap-tx-limit=0 authentication=yes \
    client-tx-limit=0 comment="Samsung J7 Prime" disabled=no forwarding=yes \
    interface=*B mac-address=20:5E:F7:E0:50:A4 private-algo=none \
    signal-range=-120..120 !time vlan-id=1 vlan-mode=default
add allow-signal-out-of-range=10s ap-tx-limit=0 authentication=yes \
    client-tx-limit=0 comment="TV Sharp" disabled=no forwarding=yes \
    interface=wlan1-HOTSPOT mac-address=1E:7F:0A:74:74:62 private-algo=none \
    signal-range=-120..120 !time vlan-id=1 vlan-mode=default
/interface wireless align
set active-mode=yes audio-max=-20 audio-min=-100 audio-monitor=\
    00:00:00:00:00:00 filter-mac=00:00:00:00:00:00 frame-size=300 \
    frames-per-second=25 receive-all=no ssid-all=no
/interface wireless cap
set bridge=none caps-man-addresses="" caps-man-certificate-common-names="" \
    caps-man-names="" certificate=none discovery-interfaces="" enabled=no \
    interfaces="" lock-to-caps-man=no static-virtual=no
/interface wireless sniffer
set channel-time=200ms file-limit=10 file-name="" memory-limit=10 \
    multiple-channels=no only-headers=no receive-errors=no streaming-enabled=\
    no streaming-max-rate=0 streaming-server=0.0.0.0
/interface wireless snooper
set channel-time=200ms multiple-channels=yes receive-errors=no
/ip address
add address=172.31.1.1/29 comment=LAN disabled=no interface=ether3-LAN \
    network=172.31.1.0
add address=10.10.10.1/24 comment=HOTSPOT disabled=no interface=wlan1-HOTSPOT \
    network=10.10.10.0
add address=172.31.2.1/28 comment="Private WiFi" disabled=no interface=\
    bridge-private network=172.31.2.0
add address=172.31.40.1/24 comment=SmartHome disabled=no interface=IoT \
    network=172.31.40.0
add address=192.168.1.100/30 disabled=no interface=ISP network=192.168.1.100
/ip cloud
set ddns-enabled=yes ddns-update-interval=none update-time=yes
/ip cloud advanced
set use-local-address=yes
/ip dhcp-client
add add-default-route=yes allow-reconfigure=no check-gateway=ping \
    default-route-distance=1 default-route-tables=default dhcp-options=\
    hostname,clientid disabled=no interface=ISP name=client1 use-broadcast=\
    always use-peer-dns=no use-peer-ntp=yes
/ip dhcp-server
add add-dns-entries-suffix=lan address-lists="" address-pool=Private-Network \
    always-broadcast=yes disabled=no dynamic-lease-identifiers=\
    client-mac,client-id interface=bridge-private lease-script="" lease-time=\
    30m name=Private support-broadband-tr101=no use-radius=no \
    use-reconfigure=yes
add add-dns-entries-suffix=lan address-lists="" address-pool=IoT disabled=no \
    dynamic-lease-identifiers=client-mac,client-id interface=IoT \
    lease-script="" lease-time=30m name=IoT support-broadband-tr101=no \
    use-radius=no use-reconfigure=no
/ip dhcp-server alert
add alert-timeout=1h disabled=yes interface=*13
/ip dhcp-server config
set accounting=yes interim-update=0s radius-password=empty store-leases-disk=\
    5m
/ip dhcp-server lease
add address=172.31.2.10 address-lists="" agent-circuit-id="" agent-remote-id=\
    "" !allow-dual-stack-queue always-broadcast=yes client-id=\
    1:ac:17:94:16:cd:10 dhcp-option="" disabled=no !insert-queue-before \
    mac-address=AC:17:94:16:CD:10 !parent-queue !queue-type server=Private
/ip dhcp-server network
add address=0.0.0.0/0 caps-manager="" dhcp-option="" dns-server="" gateway=\
    172.31.40.1 !next-server ntp-server="" wins-server=""
add address=10.10.10.0/24 caps-manager="" comment="hotspot network" \
    dhcp-option="" dns-server=1.1.1.3 gateway=10.10.10.1 !next-server \
    ntp-server="" wins-server=""
add address=172.31.1.0/29 caps-manager="" comment=LAN dhcp-option=hostname \
    dns-server=172.31.1.1,1.1.1.3 domain=Linelejan-Rumagit.net gateway=\
    172.31.1.1 !next-server ntp-server="" wins-server=""
add address=172.31.2.0/28 caps-manager="" comment=WLAN dhcp-option="" \
    dns-server=172.31.2.1,1.1.1.3,8.8.8.8 domain=Linelejan-Rumagit gateway=\
    172.31.2.1 !next-server ntp-server="" wins-server=""
add address=172.31.40.0/24 caps-manager="" dhcp-option="" dns-server=1.1.1.1 \
    gateway=172.31.40.1 !next-server ntp-server="" wins-server=""
/ip dns
set address-list-extra-time=0s allow-remote-requests=yes cache-max-ttl=1w1h1s \
    cache-size=6000KiB doh-max-concurrent-queries=50 \
    doh-max-server-connections=50 doh-timeout=1m40s max-concurrent-queries=\
    10000 max-concurrent-tcp-sessions=200 max-udp-packet-size=4096 \
    mdns-repeat-ifaces=IoT query-server-timeout=2s query-total-timeout=10s \
    servers=8.8.8.8 use-doh-server=\
    https://2rlu4q28in.cloudflare-gateway.com/dns-query verify-doh-cert=yes \
    vrf=main
/ip dns static
add address=2606:4700:4700::1003 disabled=yes name=Cloudflare ttl=1d type=AAAA
add address=216.239.35.0 disabled=yes name=time.google.com ttl=1d type=A
add address=162.159.200.1 disabled=yes name=time.cloudflare.com ttl=1d type=A
add address=94.140.15.16 disabled=yes name="AdGuard Family" ttl=1d type=A
add address=94.140.14.49 address-list=94.140.14.49 disabled=yes name=\
    https://family.adguard-dns.com/dns-query ttl=1d type=A
add address=94.140.14.15 disabled=yes regexp=\
    https://d.adguard-dns.com/dns-query/rtr-942926e3-mikrotik ttl=1d type=A
add address=1.1.1.3 disabled=yes name=\
    https://family.cloudflare-dns.com/dns-query ttl=1d type=A
add address=94.140.14.49 disabled=yes match-subdomain=yes name=\
    https://d.adguard-dns.com/dns-query/93fca145 ttl=1d type=A
add address=157.240.13.55 disabled=yes name=chat.cdn.whatsapp.net ttl=1d type=\
    A
add address=3.10.1.1 disabled=yes name=gateway.ryoline.id ttl=1d type=A
add address=1.1.1.3 disabled=yes name=\
    https://family.cloudflare-dns.com/dns-query ttl=1d type=A
add address=2a06:98c1:54::17:f649 disabled=yes name="Cloudflare Zero Trust" \
    ttl=1d type=AAAA
add address=172.64.36.1 disabled=yes name="Cloudflare Zero Trust" ttl=1d type=\
    A
add address=172.64.36.2 disabled=yes name="Cloudflare Zero Trust" ttl=1d type=\
    A
add address=3.10.1.2 disabled=yes name=dapurminahasa.com ttl=1d type=A
add address=192.168.173.91 disabled=yes name=dapurminahasa.com ttl=1d type=A
add address=192.168.1.2 disabled=yes name=gateway.ryoline.net ttl=1d type=A
add address=172.31.2.1 disabled=yes name=gateway.ryoline.net ttl=1d type=A
add address=172.31.1.1 disabled=yes name=gateway.ryoline.net ttl=1d type=A
add address=94.140.14.49 disabled=yes name=d.adguard-dns.com ttl=1d type=A
add address=94.140.14.59 disabled=yes name=d.adguard-dns.com ttl=1d type=A
add address=198.41.0.4 disabled=yes name=a.root-servers.net ttl=1d type=A
add address=172.64.36.1 disabled=yes name=\
    https://ajgcjz9ng8.cloudflare-gateway.com/dns-query ttl=1d type=A
add address=172.64.36.2 disabled=yes name=\
    https://ajgcjz9ng8.cloudflare-gateway.com/dns-query ttl=1d type=A
add address=172.64.148.235 disabled=yes name=ws.chatgpt.com ttl=1d type=A
add address=104.18.39.21 disabled=yes name=ws.chatgpt.com ttl=1d type=A
add disabled=yes name="DNS IKLAN" text="https://raw.githubusercontent.com/Stev\
    enBlack/hosts/refs/heads/master/hosts" ttl=1d type=TXT
add address=119.81.63.194 disabled=yes name=login.ml.mlbangbang.com ttl=1d \
    type=A
add address=191.150.81.20 disabled=yes name=gateway.linelejan-rumagit.net \
    ttl=5m type=A
add address=191.150.81.10 disabled=yes name=gateway.linelejan-rumagit.net \
    ttl=5m type=A
add address=1.1.1.1 disabled=yes name=\
    https://d.adguard-dns.com/dns-query/4c755dc8 ttl=1d type=A
/ip firewall address-list
add address=youtube.com disabled=no dynamic=no list=youtube.com
add address=180.250.245.141 comment="BlokDNS Indihome" disabled=yes dynamic=\
    no list=Indihome-aDns
add address=speedtest.net disabled=no dynamic=no list=hotspot-only
add address=fast.com disabled=no dynamic=no list=hotspot-only
add address=zoom.us disabled=no dynamic=no list=zoom
add address=zoomcdn.zoom.us disabled=no dynamic=no list=zoom
add address=googlevideo.com disabled=no dynamic=no list=meet
add address=fbcdn.net comment=VideoCall-Messenger disabled=no dynamic=no \
    list=messenger
/ip firewall filter
add action=drop chain=forward comment=Youtube_Drop_Pagi_sampe_jam3 \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=yes !dscp dst-address=172.31.2.10 dst-address-list=\
    youtube.com !dst-address-type !dst-limit !dst-port !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=yes !nth !out-bridge-port \
    !out-bridge-port-list out-interface=ISP !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority !protocol !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss time=\
    6h-15h,mon,tue,wed,thu,fri,sat !tls-host !tos !ttl
# inactive time
add action=drop chain=forward comment=TV !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=no !dscp dst-address=172.31.2.10 \
    !dst-address-list !dst-address-type !dst-limit !dst-port !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority !protocol !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss time=\
    0s-6h,sun,mon,tue,wed,thu,fri,sat !tls-host !tos !ttl
add action=accept chain=forward comment="Allow UPnP dstnat traffic" \
    connection-nat-state=dstnat disabled=yes
add action=jump chain=forward comment="=== UPnP Chain Start ===" disabled=yes \
    dst-port=1900 jump-target=upnp-chain protocol=udp
add action=jump chain=forward !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=yes !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit dst-port=5000-65535 \
    !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options jump-target=upnp-chain !layer7-protocol !limit log=no !nth \
    !out-bridge-port !out-bridge-port-list !out-interface !out-interface-list \
    !packet-mark !packet-size !per-connection-classifier !port !priority \
    protocol=tcp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=accept chain=forward comment="Allow established/related" \
    connection-state=established,related disabled=yes
add action=accept chain=upnp-chain comment=\
    "Izinkan UPnP antar subnet internal" disabled=yes dst-address=3.10.1.0/28 \
    src-address=172.31.1.0/29
add action=drop chain=forward comment="Drop invalid" connection-state=invalid \
    disabled=yes
add action=accept chain=upnp-cross comment=\
    "Allow SSDP unicast response cross-subnet" disabled=yes dst-port=1900 \
    protocol=udp src-address-list=upnp-subnets
add action=drop chain=upnp-cross comment="Drop UPnP from other subnets" \
    disabled=yes src-address-list=!upnp-subnets
add action=return chain=upnp-cross comment="Return to forward chain" \
    disabled=yes
add action=accept chain=upnp-chain comment=\
    "Izinkan kontrol UPnP ke router internal jika perlu" disabled=yes \
    dst-address=3.10.1.1 src-address=172.31.1.0/29
add action=drop chain=upnp-chain comment="Blok UPnP dari hotspot" disabled=\
    yes src-address=191.150.81.0/24
add action=return chain=upnp-chain comment="=== UPnP Chain End ===" disabled=\
    yes
add action=drop chain=forward comment="only game" !connection-bytes \
    !connection-limit connection-mark=no-mark !connection-nat-state \
    !connection-rate !connection-state !connection-type !content disabled=no \
    !dscp !dst-address dst-address-list=!gameOnly !dst-address-type \
    !dst-limit !dst-port !fragment !icmp-options !in-bridge-port \
    !in-bridge-port-list !in-interface !in-interface-list !ingress-priority \
    !ipsec-policy !ipv4-options !layer7-protocol !limit log=no log-prefix="" \
    !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list packet-mark=no-mark !packet-size \
    !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address src-address-list=gameOnlyUser \
    src-address-type="" !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=drop chain=forward !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=yes !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit !dst-port !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority !protocol !psd \
    !random !routing-mark !src-address src-address-list=gameOnlyUser \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=drop chain=forward !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=yes !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit !dst-port !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority !protocol !psd \
    !random !routing-mark !src-address src-address-list=hotspot-limited \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=no
add action=add-dst-to-address-list address-list=Clash-Royale&COC \
    address-list-timeout=1d59s chain=forward comment=\
    Clash-Royale&Clash-Of-Clans !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=no !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit dst-port=9339 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no log-prefix="" !nth !out-bridge-port \
    !out-bridge-port-list out-interface=ISP !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=udp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=Mobile-Legend \
    address-list-timeout=1h chain=forward comment=Mobile-Legend \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port="5000-5221,5224-5227,5229-5241,5243-\
    5287,5289-5352,5354-5509,5517,5520-5529" !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no log-prefix="" !nth !out-bridge-port !out-bridge-port-list \
    out-interface=ISP !out-interface-list !packet-mark !packet-size \
    !per-connection-classifier !port !priority protocol=tcp !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=Mobile-Legend \
    address-list-timeout=1h chain=forward !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=no !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit dst-port=\
    5517-5529,5551-5559,5601-5700,8001,8130 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no log-prefix="" !nth !out-bridge-port !out-bridge-port-list \
    out-interface=ISP !out-interface-list !packet-mark !packet-size \
    !per-connection-classifier !port !priority protocol=udp !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=WA address-list-timeout=30m \
    chain=forward comment=Whatsapp !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=no !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit dst-port=5222 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no log-prefix="" !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=tcp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment=GAMEml !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    5517,5520-5529,5551-5559,5601-5700,8443,9000-9010,9443,10003,30000-30900 \
    !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=tcp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment="GAME ML-UDP" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    5517-5529,5551-5559,5601-5700,8001,8130,8443 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority protocol=udp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment="GAME ML-UDP" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    9000-9010,9120,9992,10003,30000-30900 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority protocol=udp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment="GAME-UDP cr" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=9339 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority protocol=udp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment=GAME-TCPpubg \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    7889,10012,13004,14000,17000,17500,18081,20000-20002,20371 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=tcp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment=GAME-TCPpubg \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    7000-7999,17500,20000-20001,20500,21000,27000-27031,27036 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=udp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment="GAME-UDP cr" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=9339 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority protocol=tcp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment=GAME-TCPcodm \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    10012,17500,20000-20001,20500,21000,27020-27050 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority protocol=tcp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment=GAME-UDPcodm \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    10012,17500,20000-20001,20500,21000,27020-27050 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority protocol=udp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=add-dst-to-address-list address-list=gameOnly \
    address-list-timeout=1d chain=forward comment=GAME-UDPff \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    7000-7999,17500,20000-20001,20500,21000,27000-27031,27036 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=udp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=accept chain=input disabled=yes protocol=icmp
add action=accept chain=input connection-state=established disabled=yes
add action=accept chain=input connection-state=related disabled=yes
add action=drop chain=input disabled=yes in-interface-list=!LAN
add action=drop chain=forward comment=TV_disable !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=yes !dscp \
    dst-address=172.31.2.10 !dst-address-list !dst-address-type !dst-limit \
    !dst-port !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority !protocol !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !tos !ttl
/ip firewall mangle
add action=mark-connection chain=prerouting comment="Mobile Legends" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    5000-5221,5224-5227,5229-5241,5243-5287 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=ML-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=tcp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    5289-5352,5354-5509,5517,5520-5529 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=ML-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=tcp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    5551-5559,5601-5700,8443,9000-9010,9443,10003,30000-30900 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no new-connection-mark=ML-Conn !nth \
    !out-bridge-port !out-bridge-port-list !out-interface !out-interface-list \
    !packet-mark !packet-size passthrough=yes !per-connection-classifier \
    !port !priority protocol=tcp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=mark-connection chain=prerouting !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    5517-5529,5551-5559,5601-5700,8001,8130,8443 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=ML-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=udp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    9000-9010,9120,9992,10003,30000-30900 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=ML-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=udp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=change-dscp chain=prerouting comment="DSCP Mobile Legend " \
    !connection-bytes !connection-limit connection-mark=ML-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content !dscp !dst-address !dst-address-list !dst-address-type \
    !dst-limit !dst-port !fragment !icmp-options !in-bridge-port \
    !in-bridge-port-list !in-interface !in-interface-list !ingress-priority \
    !ipsec-policy !ipv4-options !layer7-protocol !limit log=no new-dscp=46 \
    !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size passthrough=yes \
    !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=mark-packet chain=prerouting comment="Mobile Legends Packet" \
    !connection-bytes !connection-limit connection-mark=ML-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-packet-mark=GAME-Priority-Packet !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=no !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting comment="Clash Royale" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=9339 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=CR-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=tcp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=9339 \
    !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no new-connection-mark=CR-Conn \
    !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size passthrough=yes \
    !per-connection-classifier !port !priority protocol=udp !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=change-dscp chain=prerouting comment="DSCP COC & CR" \
    !connection-limit connection-mark=CR-Conn disabled=no !dst-limit !limit \
    log=no new-dscp=46 passthrough=yes !psd !time
add action=mark-packet chain=prerouting comment="Clash Royale Packet" \
    !connection-bytes !connection-limit connection-mark=CR-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-packet-mark=GAME-Priority-Packet !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=no !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=forward comment="TikTok fix" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options layer7-protocol=tiktok \
    !limit log=no new-connection-mark=TikTok-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=forward !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=no !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit !dst-port !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    layer7-protocol=tiktok !limit log=no new-connection-mark=TikTok-Conn !nth \
    !out-bridge-port !out-bridge-port-list !out-interface !out-interface-list \
    !packet-mark !packet-size passthrough=no !per-connection-classifier !port \
    !priority protocol=udp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=mark-packet chain=forward comment="TikTok Packet" \
    !connection-bytes !connection-limit connection-mark=TikTok-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-packet-mark=TikTok-Packet !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=change-dscp chain=prerouting comment="DSCP TikTok" \
    !connection-bytes !connection-limit connection-mark=TikTok-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-dscp=8 !nth !out-bridge-port !out-bridge-port-list \
    !out-interface !out-interface-list !packet-mark !packet-size passthrough=\
    yes !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=mark-connection chain=prerouting comment=PUBG !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    7889,10012,13004,14000,17000,17500,18081,20000-20002,20371 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no new-connection-mark=PUBG-Conn !nth \
    !out-bridge-port !out-bridge-port-list !out-interface !out-interface-list \
    !packet-mark !packet-size passthrough=yes !per-connection-classifier \
    !port !priority protocol=tcp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=mark-connection chain=prerouting disabled=no dst-port=\
    7000-7999,17500,20000-20001,20500,21000,27000-27031,27036 \
    new-connection-mark=PUBG-Conn passthrough=yes protocol=udp
add action=change-dscp chain=prerouting comment="DSCP PUBG" !connection-limit \
    connection-mark=PUBG-Conn disabled=no !dst-limit !limit log=no new-dscp=\
    46 passthrough=yes !psd !time
add action=mark-packet chain=prerouting comment="PUBG Packet" \
    !connection-bytes !connection-limit connection-mark=PUBG-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-packet-mark=GAME-Priority-Packet !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=no !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting comment="Free Fire" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=\
    6006,6008,7008,8008,9008,10000-10013,10100,11000-11019,12008,13008 \
    !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no new-connection-mark=FF-Conn \
    !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size passthrough=yes \
    !per-connection-classifier !port !priority protocol=udp !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=mark-connection chain=prerouting !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    7000-7999,17500,20000-20001,20500,21000,27000-27031,27036 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no new-connection-mark=CODM-Conn !nth \
    !out-bridge-port !out-bridge-port-list !out-interface !out-interface-list \
    !packet-mark !packet-size passthrough=yes !per-connection-classifier \
    !port !priority protocol=udp !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=change-dscp chain=prerouting comment="DSCP Free Fire" \
    !connection-bytes !connection-limit connection-mark=FF-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-dscp=46 !nth !out-bridge-port !out-bridge-port-list \
    !out-interface !out-interface-list !packet-mark !packet-size passthrough=\
    yes !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=mark-packet chain=prerouting comment="Free Fire Packet" \
    !connection-bytes !connection-limit connection-mark=FF-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-packet-mark=GAME-Priority-Packet !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=no !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting comment=CODM !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=no !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit dst-port=\
    10012,17500,20000-20001,20500,21000,27020-27050 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=CODM-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=tcp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-packet chain=prerouting comment="CODM Packet" \
    !connection-bytes !connection-limit connection-mark=CODM-Conn \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-packet-mark=GAME-Priority-Packet !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=no !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=change-dscp chain=prerouting comment="DSCP CODM" !connection-bytes \
    !connection-limit connection-mark=CODM-Conn !connection-nat-state \
    !connection-rate !connection-state !connection-type !content disabled=no \
    !dscp !dst-address !dst-address-list !dst-address-type !dst-limit \
    !dst-port !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no new-dscp=46 !nth \
    !out-bridge-port !out-bridge-port-list !out-interface !out-interface-list \
    !packet-mark !packet-size passthrough=yes !per-connection-classifier \
    !port !priority !protocol !psd !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-flags \
    !tcp-mss !time !tls-host !ttl
add action=mark-connection chain=prerouting comment="ICMP Connection" \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=ICMP-Conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=icmp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-packet chain=prerouting comment="ICMP Packet" \
    connection-mark=ICMP-Conn disabled=no new-packet-mark=ICMP-Packet \
    passthrough=no
add action=change-ttl chain=postrouting comment=\
    Limit-Sharing-Internet-ALL_TTL-1 !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content disabled=no !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit !dst-port !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no log-prefix="" new-ttl=set:1 !nth \
    !out-bridge-port !out-bridge-port-list out-interface=!ISP \
    out-interface-list=list-ttl1 !packet-mark !packet-size passthrough=no \
    !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=mark-connection chain=prerouting comment=YouTube !connection-bytes \
    !connection-limit !connection-mark !connection-nat-state !connection-rate \
    !connection-state !connection-type !content disabled=yes !dscp \
    !dst-address dst-address-list=youtube.com !dst-address-type !dst-limit \
    !dst-port !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no new-connection-mark=\
    YouTube-Block !nth !out-bridge-port !out-bridge-port-list !out-interface \
    !out-interface-list !packet-mark !packet-size passthrough=yes \
    !per-connection-classifier !port !priority protocol=tcp !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=accept chain=prerouting comment="Kill QUIC early" disabled=yes \
    port=443 protocol=udp
add action=mark-connection chain=prerouting comment=VideoCall*meet \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=yes !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=3478-3481 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=VideoCall_conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=udp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting comment=VideoCall*Zoom \
    !connection-bytes !connection-limit !connection-mark \
    !connection-nat-state !connection-rate !connection-state !connection-type \
    !content disabled=yes !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit dst-port=50000-65000 !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no new-connection-mark=VideoCall_conn !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size passthrough=yes !per-connection-classifier !port !priority \
    protocol=udp !psd !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host !ttl
add action=mark-connection chain=prerouting comment=VideoCall disabled=yes \
    dst-address-list=zoom new-connection-mark=VideoCall_conn passthrough=yes \
    protocol=udp
add action=mark-connection chain=prerouting comment=VideoCall disabled=yes \
    dst-address-list=meet new-connection-mark=VideoCall_conn passthrough=yes \
    protocol=udp
add action=mark-packet chain=postrouting comment=VideoCall !connection-bytes \
    !connection-limit connection-mark=VideoCall_conn !connection-nat-state \
    !connection-rate !connection-state !connection-type !content disabled=yes \
    !dscp !dst-address !dst-address-list !dst-address-type !dst-limit \
    !dst-port !fragment !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy \
    !ipv4-options !layer7-protocol !limit log=no new-packet-mark=\
    VideoCall_upload !nth !out-bridge-port !out-bridge-port-list \
    !out-interface !out-interface-list !packet-mark !packet-size passthrough=\
    yes !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=no !to-addresses !to-ports
add action=masquerade chain=srcnat comment=Internet !connection-bytes \
    !connection-limit !connection-mark !connection-rate !connection-type \
    !content disabled=no !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !ipv4-options !layer7-protocol !limit \
    log=no log-prefix="" !nth !out-bridge-port !out-bridge-port-list \
    out-interface=ISP !out-interface-list !packet-mark !packet-size \
    !per-connection-classifier !port !priority !protocol !psd !random \
    !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-mss !time !to-addresses !to-ports !ttl
add action=redirect chain=dstnat comment="redirect to DNS local" \
    !connection-bytes !connection-limit !connection-mark !connection-rate \
    !connection-type !content disabled=no !dscp !dst-address \
    !dst-address-list !dst-address-type !dst-limit dst-port=53 !fragment \
    !icmp-options !in-bridge-port !in-bridge-port-list !in-interface \
    !in-interface-list !ingress-priority !ipsec-policy !ipv4-options \
    !layer7-protocol !limit log=no log-prefix="" !nth !out-bridge-port \
    !out-bridge-port-list !out-interface !out-interface-list !packet-mark \
    !packet-size !per-connection-classifier !port !priority protocol=udp !psd \
    !random !routing-mark !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-mss !time !to-addresses to-ports=53 !ttl
/ip firewall raw
add action=drop chain=prerouting comment="Blok Netbios dan Winbox Scan" \
    !content disabled=yes !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !fragment !icmp-options \
    in-interface=*13 in-interface-list=list_public !ingress-priority \
    !ipsec-policy !ipv4-options !limit log=yes log-prefix="" !nth \
    !out-interface !out-interface-list !packet-size \
    !per-connection-classifier port=\
    21,53,135,139,445,1723,2000,8291,2001,2828,8080 !priority protocol=tcp \
    !psd !random !src-address !src-address-list !src-address-type \
    !src-mac-address !src-port !tcp-flags !tcp-mss !time !tls-host !ttl
add action=drop chain=prerouting comment="RAW Block Hotspot to Modem" \
    dst-address=192.168.1.1 in-interface=wlan1-HOTSPOT
add action=drop chain=prerouting comment="RAW Block Hotspot to Modem Network" \
    dst-address=192.168.1.0/24 in-interface=wlan1-HOTSPOT
add action=drop chain=prerouting comment="RAW Block Hotspot to MikroTik" \
    dst-address=10.10.10.1 in-interface=wlan1-HOTSPOT
/ip firewall service-port
set ftp disabled=yes ports=21
set tftp disabled=yes ports=69
set irc disabled=yes ports=6667
set h323 disabled=yes
set sip disabled=yes ports=5060,5061 sip-direct-media=yes sip-timeout=1h
set pptp disabled=no
set rtsp disabled=yes ports=554
set udplite disabled=no
set dccp disabled=no
set sctp disabled=no
/ip hotspot
add address-pool=hs-pool-Tamu addresses-per-mac=1 disabled=no idle-timeout=\
    10s interface=wlan1-HOTSPOT keepalive-timeout=10s login-timeout=10s name=\
    hotspot1 profile=hsprof_tamu
/ip hotspot ip-binding
add comment=GalaxyA20 disabled=yes mac-address=A4:D9:90:49:4B:2D server=all \
    type=bypassed
add comment="Realme C53" disabled=no mac-address=70:28:04:1A:80:1D server=all \
    type=bypassed
/ip hotspot service-port
set ftp disabled=yes ports=21
/ip hotspot user
set [ find default=yes ] comment="counters and limits for trial users" \
    disabled=no name=default-trial server=all
add disabled=yes mac-address=DA:18:A4:26:D8:37 name=admin profile=default \
    server=all
add disabled=no email=ryolinelejan01@gmail.com limit-bytes-total=\
    1350000000000 name=taMu profile=tamu server=all
add disabled=no name=family profile=family server=hotspot1
add disabled=no mac-address=54:C0:78:19:3E:83 name=juan profile=juan server=\
    hotspot1
add disabled=no mac-address=EC:46:2C:B6:8C:0D name=andrew profile=default \
    server=hotspot1
add disabled=no name=game profile=game server=all
add disabled=no mac-address=A4:D9:90:49:4B:2D name=ryoline profile=default \
    server=all
add disabled=no name=minecraftlan profile=Minecraft server=all
add disabled=yes name=111 profile=default server=hotspot1
add disabled=no limit-bytes-total=1000000000000 name=tamu profile=tamu \
    server=hotspot1
add disabled=no name=use profile=test_1menit server=hotspot1
add disabled=no mac-address=70:28:04:1A:80:1D name=nux profile=teman server=\
    hotspot1
/ip hotspot user profile
add add-mac-cookie=yes address-list="" address-pool=*5 idle-timeout=none \
    !insert-queue-before keepalive-timeout=1m mac-cookie-timeout=3d name=\
    private !parent-queue !queue-type rate-limit=1m/1m shared-users=5 \
    status-autorefresh=1m transparent-proxy=no
add add-mac-cookie=yes address-list=Minecraft address-pool=*A advertise=no \
    idle-timeout=none !insert-queue-before keepalive-timeout=2m \
    mac-cookie-timeout=3d name=Minecraft open-status-page=always \
    !parent-queue !queue-type shared-users=90 status-autorefresh=1m \
    transparent-proxy=yes
/ip hotspot walled-garden
add action=allow disabled=no dst-host=lens.google.com !dst-port !method !path \
    server=hotspot1 !src-address
add action=allow disabled=no dst-host=fonts.googleapis.com !dst-port !method \
    path="/icon\?family=Material+Icons" !server !src-address
add action=allow disabled=no dst-host=fonts.googleapis.com !dst-port !method \
    !path !server !src-address
add action=allow disabled=no dst-host=fonts.gstatic.com !dst-port !method \
    !path !server !src-address
add action=allow disabled=no dst-host=cdnjs.cloudflare.com !dst-port !method \
    !path !server !src-address
/ip ipsec policy
set 0 disabled=no dst-address=::/0 group=default proposal=default protocol=\
    all src-address=::/0 template=yes
/ip ipsec settings
set accounting=yes ddos-cookie-threshold=20 interim-update=0s \
    xauth-use-radius=no
/ip kid-control device
add disabled=no mac-address=A4:D9:90:49:4B:2D name="A4:D9:90:49:4B:2D;2" \
    user=""
/ip media settings
set thumbnails=""
/ip nat-pmp
set enabled=no
/ip proxy
set always-from-cache=no anonymous=no cache-administrator=\
    ryolinelejan01@gmail.com cache-hit-dscp=4 cache-on-disk=no cache-path=\
    web-proxy enabled=yes max-cache-object-size=2048KiB max-cache-size=\
    unlimited max-client-connections=600 max-fresh-time=3d \
    max-server-connections=600 parent-proxy=:: parent-proxy-port=0 port=8080 \
    serialize-connections=no src-address=::
/ip proxy access
add action=allow disabled=no !dst-address !dst-host !dst-port !local-port \
    !method !path !src-address
add action=redirect action-data=server.ryoline.net/ disabled=no !dst-address \
    dst-host=gateway.ryoline.net !dst-port !local-port method=GET path="" \
    !src-address
add action=allow disabled=no !dst-address dst-host=gateway.ryoline.net \
    !dst-port !local-port method=GET path=/flash/web_proxy/index.html \
    !src-address
/ip proxy direct
add action="(unknown)" disabled=no !dst-address dst-host=gateway.ryoline.net \
    !dst-port !local-port !method !path !src-address
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.1.1
/ip service
set ftp available-from="" disabled=no max-sessions=20 port=21 vrf=main
set ssh available-from="" disabled=no max-sessions=20 port=22 vrf=main
set www available-from=172.31.1.0/29,172.31.2.0/28 disabled=no max-sessions=1 \
    port=80 vrf=main
set www-ssl available-from="" certificate=none disabled=yes max-sessions=20 \
    port=443 tls-version=any vrf=main
set reverse-proxy available-from="" certificate=none disabled=yes \
    max-sessions=20 port=443 tls-version=any vrf=main
set telnet available-from=172.31.2.0/28,172.31.1.0/29,172.31.2.2/32 disabled=\
    no max-sessions=1 port=2001 vrf=main
set winbox available-from=172.31.2.0/29,172.31.1.0/29 disabled=no \
    max-sessions=2 port=8291 vrf=main
set api-ssl available-from="" certificate=none disabled=yes max-sessions=20 \
    port=8443 tls-version=any vrf=main
set api available-from="" disabled=yes max-sessions=20 port=8728 vrf=main
/ip smb shares
set [ find default=yes ] directory=/flash/pub disabled=yes invalid-users="" \
    name=pub read-only=no require-encryption=no valid-users=""
add directory=/usb1-part1 disabled=no invalid-users="" name=usb read-only=no \
    require-encryption=no valid-users=""
/ip socks
set auth-method=none connection-idle-timeout=2m enabled=no max-connections=\
    200 port=1080 version=4 vrf=main
/ip ssh
set ciphers=auto forwarding-enabled=no host-key-size=2048 host-key-type=rsa \
    password-authentication=yes publickey-authentication-options=none \
    strong-crypto=no
/ip tftp settings
set max-block-size=4096
/ip traffic-flow
set active-flow-timeout=30m cache-entries=16k enabled=no \
    inactive-flow-timeout=15s interfaces=all packet-sampling=no \
    sampling-interval=0 sampling-space=0
/ip traffic-flow ipfix
set bytes=yes dst-address=yes dst-address-mask=yes dst-mac-address=yes \
    dst-port=yes first-forwarded=yes gateway=yes icmp-code=yes icmp-type=yes \
    igmp-type=yes in-interface=yes ip-header-length=yes ip-total-length=yes \
    ipv6-flow-label=yes is-multicast=yes last-forwarded=yes nat-dst-address=\
    yes nat-dst-port=yes nat-events=no nat-src-address=yes nat-src-port=yes \
    out-interface=yes packets=yes protocol=yes src-address=yes \
    src-address-mask=yes src-mac-address=yes src-port=yes sys-init-time=yes \
    tcp-ack-num=yes tcp-flags=yes tcp-seq-num=yes tcp-window-size=yes tos=yes \
    ttl=yes udp-length=yes
/ip upnp
set allow-disable-external-interface=yes enabled=no show-dummy-rule=yes
/ip upnp interfaces
add disabled=no !forced-ip interface=ether2-PRIVATE-TV type=internal
add disabled=no !forced-ip interface=bridge-private type=internal
add disabled=no !forced-ip interface=ISP type=external
/ipv6 address
add address=2001:6:4:f004:de2c:6eff:fe3c:8359/64 advertise=yes \
    auto-link-local=yes disabled=no eui-64=yes from-pool="" interface=\
    bridge-private no-dad=no
add address=::f006:1:0:1/64 advertise=yes auto-link-local=yes disabled=no \
    eui-64=no from-pool=private interface=ether3-LAN no-dad=no
/ipv6 dhcp-client
add accept-prefix-without-address=no add-default-route=yes allow-reconfigure=\
    no check-gateway=ping !custom-iana-id !custom-iapd-id \
    default-route-distance=1 default-route-tables=default dhcp-options="" \
    dhcp-options="" disabled=no interface=ISP pool-name=dhcpV6_Client \
    !pool-prefix-length prefix-address-lists="" prefix-hint=::/0 request=\
    address,prefix use-peer-dns=no validate-server-duid=no
/ipv6 dhcp-server
add address-lists="" address-pool=private dhcp-option="" disabled=no \
    ignore-ia-na-bindings=no interface=bridge-private lease-time=3d name=\
    lan_private preference=255 prefix-pool=private rapid-commit=yes \
    route-distance=1 use-radius=no use-reconfigure=no
/ipv6 firewall filter
add action=add-dst-to-address-list address-list=ipv6-traffic \
    address-list-timeout=1d chain=forward !connection-bytes !connection-limit \
    !connection-mark !connection-nat-state !connection-rate !connection-state \
    !connection-type !content !dscp !dst-address !dst-address-list \
    !dst-address-type !dst-limit !dst-port !headers !hop-limit !icmp-options \
    !in-bridge-port !in-bridge-port-list !in-interface !in-interface-list \
    !ingress-priority !ipsec-policy !limit log=no !nth !out-bridge-port \
    !out-bridge-port-list out-interface=wlan1-HOTSPOT !out-interface-list \
    !packet-mark !packet-size !per-connection-classifier !port !priority \
    !protocol !random !routing-mark !src-address !src-address-list \
    !src-address-type !src-mac-address !src-port !tcp-flags !tcp-mss !time \
    !tls-host
add action=accept chain=input comment="IPv6: accept established related" \
    connection-state=established,related,untracked
add action=drop chain=input comment="IPv6: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="IPv6: allow ICMPv6" protocol=icmpv6
add action=drop chain=input comment="IPv6: drop WAN access to router" \
    in-interface=ISP
add action=accept chain=forward comment="IPv6: forward established related" \
    connection-state=established,related,untracked
add action=drop chain=forward comment="IPv6: forward drop invalid" \
    connection-state=invalid
add action=accept chain=forward comment="IPv6: forward ICMPv6" protocol=\
    icmpv6
add action=accept chain=forward comment="IPv6: LAN to Internet" in-interface=\
    bridge-private out-interface=ISP
add action=drop chain=forward comment="IPv6: block new WAN to LAN" \
    connection-state=new in-interface=ISP out-interface=bridge-private
/ipv6 firewall nat
add action=masquerade chain=srcnat !connection-bytes !connection-limit \
    !connection-mark !connection-rate !connection-type !content !dscp \
    !dst-address !dst-address-list !dst-address-type !dst-limit !dst-port \
    !headers !hop-limit !icmp-options !in-bridge-port !in-bridge-port-list \
    !in-interface !in-interface-list !ingress-priority !ipsec-policy !limit \
    log=no !nth !out-bridge-port !out-bridge-port-list out-interface=ISP \
    !out-interface-list !packet-mark !packet-size !per-connection-classifier \
    !port !priority !protocol !random !routing-mark !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-mss \
    !time !to-address !to-ports
/ipv6 nd
set [ find default=yes ] advertise-dns=yes advertise-mac-address=yes \
    disabled=no !dns hop-limit=unspecified interface=all \
    managed-address-configuration=no mtu=unspecified other-configuration=no \
    !pref64 ra-delay=3s ra-interval=3m20s-10m ra-lifetime=30m ra-preference=\
    medium reachable-time=unspecified retransmit-interval=unspecified
/ipv6 nd prefix default
set autonomous=yes dhcp6-pd-preferred=no preferred-lifetime=1w \
    valid-lifetime=4w2d
/ipv6 nd settings
set router-advertisement-ignored-options="" \
    router-advertisement-route-distance=1
/mpls settings
set allow-fast-path=yes dynamic-label-range=16-1048575 propagate-ttl=yes
/ppp aaa
set accounting=yes enable-ipv6-accounting=no interim-update=0s \
    use-circuit-id-in-nas-port-id=no use-radius=no
/ppp profile
add address-list="" !bridge !bridge-horizon bridge-learning=default \
    !bridge-path-cost !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=default !dhcpv6-lease-time \
    !dhcpv6-use-radius dns-server=1.1.1.3,8.8.8.8 !idle-timeout \
    !incoming-filter !insert-queue-before !interface-list local-address=*10 \
    name=profile-pppoe-sharing-upto-75mbps on-down="" on-up="" only-one=yes \
    !outgoing-filter parent-queue=queuePPPOE queue-type=\
    default-small/pcq-download-default rate-limit="65m/20m 75m/25m" \
    remote-address=*F !remote-ipv6-prefix-reuse !session-timeout \
    use-compression=yes use-encryption=yes use-ipv6=default use-mpls=default \
    use-upnp=default !wins-server
add address-list="" !bridge !bridge-horizon bridge-learning=default \
    !bridge-path-cost !bridge-port-priority !bridge-port-trusted \
    !bridge-port-vid change-tcp-mss=default !dhcpv6-lease-time \
    !dhcpv6-use-radius dns-server=1.1.1.3,8.8.8.8 !idle-timeout \
    !incoming-filter !insert-queue-before !interface-list local-address=*10 \
    name=5m on-down="" on-up="" only-one=yes !outgoing-filter parent-queue=\
    queuePPPOE queue-type="Game Low Latency/Game Low Latency" rate-limit=\
    "5m/5m 6m/6m" remote-address=*F !remote-ipv6-prefix-reuse \
    !session-timeout use-compression=yes use-encryption=yes use-ipv6=default \
    use-mpls=default use-upnp=default !wins-server
/ppp secret
add caller-id="" disabled=no ipv6-routes="" limit-bytes-in=0 limit-bytes-out=\
    0 !local-address name=ppp1 profile=ryoo !remote-address \
    !remote-ipv6-prefix routes="" service=pptp
add caller-id="" disabled=no ipv6-routes="" limit-bytes-in=0 limit-bytes-out=\
    0 !local-address name=ryoline profile=ovpn-ryo !remote-address \
    !remote-ipv6-prefix routes="" service=ovpn
add caller-id="" disabled=no ipv6-routes="" limit-bytes-in=0 limit-bytes-out=\
    0 !local-address name=ryo profile=test !remote-address \
    !remote-ipv6-prefix routes="" service=pptp
add caller-id="" disabled=no ipv6-routes="" limit-bytes-in=0 limit-bytes-out=\
    0 !local-address name=@sharing profile=profile-pppoe-sharing-upto-75mbps \
    !remote-address !remote-ipv6-prefix routes="" service=pppoe
add caller-id="" disabled=no ipv6-routes="" limit-bytes-in=0 limit-bytes-out=\
    0 !local-address name=5mbps profile=5m !remote-address \
    !remote-ipv6-prefix routes="" service=pppoe
add caller-id="" disabled=no ipv6-routes="" limit-bytes-in=0 limit-bytes-out=\
    0 !local-address name=vpn profile=default !remote-address \
    !remote-ipv6-prefix routes="" service=any
/queue simple
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=no limit-at=0/0 max-limit=1M/1M name=MOBILE-LEGEND_Traffic \
    packet-marks=ML-Packet parent=none priority=1/4 queue=\
    "Game Low Latency/pcq-download-default" target=\
    "wlan1-HOTSPOT,ether5-PRIVATE-Wireless ,*8" !time total-limit-at=10M \
    total-max-limit=15M total-priority=1
add bucket-size=0.1/0.1 burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s \
    disabled=no limit-at=20M/70M max-limit=20M/75M name=queuePPPOE2k \
    packet-marks="" parent=none priority=8/8 queue=\
    default-small/default-small target=ether4-PPPOE,*8 !time
/radius incoming
set accept=no port=3799 vrf=main
/routing igmp-proxy
set query-interval=2m5s query-response-interval=10s quick-leave=no
/routing igmp-proxy interface
add alternative-subnets=0.0.0.0/0 disabled=yes interface=ISP threshold=1 \
    upstream=yes
add alternative-subnets="" disabled=yes interface=bridge-private threshold=1 \
    upstream=no
add alternative-subnets="" disabled=yes interface=ether3-LAN threshold=1 \
    upstream=no
/routing settings
set check-gateway-ping-count=2 check-gateway-ping-interval=10s \
    check-gateway-ping-timeout=1s policy-rules=\
    mangle,vrf-lookup,vrf-unreach,local,user,main single-process=yes
/snmp
set contact="" enabled=no engine-id-suffix="" location="" src-address=:: \
    trap-community=public trap-generators=temp-exception trap-target="" \
    trap-version=1 vrf=main
/system clock
set time-zone-autodetect=no time-zone-name=Asia/Makassar
/system clock manual
set dst-delta=+00:00 dst-end="1970-01-01 00:00:00" dst-start=\
    "1970-01-01 00:00:00" time-zone=+00:00
/system identity
set name="MikroTik Utama"
/system leds
set 0 disabled=no interface=ISP leds=led1 type=interface-activity
set 1 disabled=no interface=*8 leds=user-led type=interface-status
set 2 disabled=no interface="ether5-PRIVATE-Wireless " leds=led5 type=\
    interface-activity
set 3 disabled=no interface=ether2-PRIVATE-TV leds=led2 type=interface-status
set 4 disabled=no interface=ether3-LAN leds=led3 type=interface-status
add disabled=no interface=ether4-PPPOE leds=led4 type=interface-status
/system leds settings
set all-leds-off=never
/system logging
set 0 action=memory disabled=no prefix="" regex="" topics=info
set 1 action=memory disabled=no prefix="" regex="" topics=error
set 2 action=memory disabled=no prefix="" regex="" topics=warning
set 3 action=memory disabled=no prefix="" regex="" topics=critical
add action=memory disabled=no prefix="" regex="" topics=error,manager,account
add action=memory disabled=no prefix="" regex="" topics=dns,update
add action=memory disabled=no prefix="" regex="" topics=pppoe,ppp
/system note
set note="" show-at-cli-login=no show-at-login=yes
/system ntp client
set enabled=yes mode=unicast servers="time.google.com,0.id.pool.ntp.org,1.id.p\
    ool.ntp.org,2.id.pool.ntp.org,3.id.pool.ntp.org,time.aws.com" vrf=main
/system ntp server
set auth-key=none broadcast=yes broadcast-addresses="" enabled=yes \
    local-clock-stratum=5 manycast=no multicast=yes use-local-clock=yes vrf=\
    main
/system ntp client servers
add address=time.google.com auth-key=none disabled=no iburst=yes max-poll=10 \
    min-poll=6
add address=0.id.pool.ntp.org auth-key=none disabled=no iburst=yes max-poll=\
    10 min-poll=6
add address=1.id.pool.ntp.org auth-key=none disabled=no iburst=yes max-poll=\
    10 min-poll=6
add address=2.id.pool.ntp.org auth-key=none disabled=no iburst=yes max-poll=\
    10 min-poll=6
add address=3.id.pool.ntp.org auth-key=none disabled=no iburst=yes max-poll=\
    10 min-poll=6
add address=time.aws.com auth-key=none disabled=no iburst=yes max-poll=10 \
    min-poll=6
/system package local-update mirror
set check-interval=1d enabled=yes primary-server=3.10.1.2 secondary-server=\
    0.0.0.0 user=""
/system package local-update update-package-source
add address=3.10.1.2 user=admin
/system package update
set channel=stable check-certificate=yes ip-version=auto mode=https
/system resource hardware usb-settings
set authorization=no
/system resource irq
set 0 cpu=auto
set 1 cpu=auto
set 2 cpu=auto
set 3 cpu=auto
/system routerboard reset-button
set enabled=no hold-time=0s..1m on-event=""
/system routerboard settings
set auto-upgrade=no boot-device=nand-if-fail-then-ethernet boot-protocol=\
    bootp force-backup-booter=no preboot-etherboot=disabled \
    preboot-etherboot-server=any protected-routerboot=disabled \
    reformat-hold-button=20s reformat-hold-button-max=10m silent-boot=no
/system scheduler
add !days disabled=no interval=1w name=autoBackup on-event=\
    "/sys script run autoBackup" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2025-04-16 start-time=12:00:00
add !days disabled=no interval=1d name=\
    "Kirim Notif penggunaan data ke Telegram " on-event=\
    "/sys script run kirimPenggunaanData" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2025-04-15 start-time=12:00:00
add !days disabled=yes interval=1d name=reset-midnight on-event=\
    "/system script run reset-login-count" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2025-06-04 start-time=00:00:00
add !days disabled=no interval=1d name=schedule1 on-event=\
    "/sys script runduckdns_update" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2025-06-11 start-time=00:00:00
add !days disabled=no interval=0s name=restore on-event=\
    "/sys script run restore-config" policy=reboot,write,policy start-date=\
    2025-09-25 start-time=03:00:00
add !days disabled=no interval=0s name=\
    "Hotspot-Services-auto-Restart(Schedule)" on-event=\
    Hotspot-Services-auto-Restart policy=reboot start-time=startup
/system watchdog
set auto-send-supout=no automatic-supout=yes ping-start-after-boot=5m \
    ping-timeout=1m watch-address=none watchdog-timer=yes
/tool bandwidth-server
set allocate-udp-ports-from=2000 allowed-addresses4="" allowed-addresses6="" \
    authenticate=yes enabled=no max-sessions=100
/tool e-mail
set certificate-verification=no from=ryolinelejan0@gmail.com port=587 server=\
    74.125.68.109 tls=starttls user=ryolinelejan0@gmail.com vrf=main
/tool graphing
set page-refresh=300 store-every=5min
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
/tool mac-server ping
set enabled=no
/tool romon
set enabled=no id=00:00:00:00:00:00
/tool romon port
set [ find default=yes ] cost=100 disabled=no forbid=no interface=all
/tool sms
set allowed-number="" channel=0 polling=no port=none receive-enabled=no \
    remove-sent-sms-after-send=no sms-storage=sim
/tool sniffer
set file-limit=1000KiB file-name="" filter-cpu="" filter-direction=any \
    filter-dst-ip-address="" filter-dst-ipv6-address="" \
    filter-dst-mac-address="" filter-dst-port="" filter-interface=\
    bridge-private filter-ip-address="" filter-ip-protocol="" \
    filter-ipv6-address="" filter-mac-address="" filter-mac-protocol="" \
    filter-operator-between-entries=or filter-port="" filter-size="" \
    filter-src-ip-address="" filter-src-ipv6-address="" \
    filter-src-mac-address="" filter-src-port="" filter-stream=no \
    filter-vlan="" max-packet-size=2048 memory-limit=100KiB memory-scroll=yes \
    only-headers=no quick-rows=20 quick-show-frame=no streaming-enabled=no \
    streaming-server=0.0.0.0:37008
/tool traffic-generator
set latency-distribution-max=100us measure-out-of-order=yes \
    stats-samples-to-keep=100 test-id=0
/tool traffic-generator port
add disabled=no interface=*8 name=port1
/tool traffic-monitor
add disabled=no interface=ISP name=tmon1 on-event="" threshold=30000000 \
    traffic=transmitted trigger=above
/tr069-client
set acs-url="" check-certificate=yes client-certificate=none \
    connection-request-port=7547 connection-request-username="" enabled=no \
    periodic-inform-enabled=yes periodic-inform-interval=1d \
    provisioning-code="" username=""
/user aaa
set accounting=yes default-group=read exclude-groups="" interim-update=0s \
    use-radius=no
/user settings
set minimum-categories=0 minimum-password-length=0
/user-manager
set accounting-port=1813 authentication-port=1812 certificate=none enabled=no \
    radsec-certificate=none require-message-auth=yes-access-request \
    use-profiles=no
/user-manager advanced
set paypal-allow=no paypal-currency=USD paypal-signature="" \
    paypal-use-sandbox=no paypal-user="" web-private-username=""
