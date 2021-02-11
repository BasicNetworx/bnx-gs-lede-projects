. /lib/functions.sh

metric_offset=30
add_iface() {
    iface=$1
    dev=$2

    uci set network.$iface='interface'
    uci set network.$iface.ipv6='0'
    uci set network.$iface.proto='qmi'
    uci set network.$iface.device=$dev
    uci set network.$iface.apn='internet'
    uci set network.$iface.pdptype='ipv4'
    uci set network.$iface.metric=$((metric_offset))
    metric_offset=$((metric_offset+10))
}

check_add_iface() {
    iface=$1
    dev=$2
    config_get result $iface proto
    if [ -z $result ]; then
        add_iface $iface $dev
    fi
}

config_load network
check_add_iface "Sim1" "/dev/cdc-wdm0"
check_add_iface "Sim2" "/dev/cdc-wdm1"
uci commit
