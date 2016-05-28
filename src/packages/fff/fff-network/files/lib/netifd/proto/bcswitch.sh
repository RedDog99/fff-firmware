#!/bin/sh

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

proto_bcswitch_init_config() {
    proto_config_add_string "mesh"
    proto_config_add_string "mesh_no_rebroadcast"
}

proto_bcswitch_setup() {
    local config="$1"
    local iface="$2"

    ip link add ethmesh type dummy

    tc qdisc add dev eth0 ingress

    tc filter add dev eth0 parent ffff: \
        protocol 0x4305 \
        u32 match u8 0 0 \
        action mirred egress redirect dev ethmesh

    tc qdisc add dev ethmesh handle 1: root prio
    tc filter add dev ethmesh parent 1: \
        protocol all \
        u32 match u8 0 0 \
        action mirred egress redirect dev eth0

    ip link set ethmesh up

    echo "$mesh" > "/sys/class/net/ethmesh/batman_adv/mesh_iface"
    [ -n "$mesh_no_rebroadcast" ] && echo "$mesh_no_rebroadcast" > "/sys/class/net/ethmesh/batman_adv/no_rebroadcast"

    proto_init_update "$iface" 1
    proto_send_update "$config"
}

proto_bcswitch_teardown() {
    local config="$1"
    local iface="$2"

#    echo "none" > "/sys/class/net/ethmesh/batman_adv/mesh_iface" || true
#    
#    ip link set dev ethclient down
#    ip link set dev ethclientbr down
#    
#    ebtables -D FORWARD -p 0x4305 -o ethclientbr -j DROP
#    ebtables -D FORWARD -p 0x4305 -i ethclientbr -j DROP
#    
#    ip link del ethclient type veth peer name ethclientbr
#
#    ip link set dev ethmesh down
#    ip link set dev ethmeshbr down
#    
#    ebtables -D FORWARD -p ! 0x4305 -o ethmeshbr -j DROP
#    ebtables -D FORWARD -p ! 0x4305 -i ethmeshbr -j DROP
#
#    ip link del ethmesh type veth peer name ethmeshbr
#
#    ebtables -D INPUT --logical-in "$iface" -j DROP
#    ebtables -D OUTPUT --logical-out "$iface" -j DROP
}

add_protocol bcswitch
