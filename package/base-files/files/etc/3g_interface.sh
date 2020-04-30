. /lib/functions.sh

add_iface() {
    iface=$1
    dev=$2

    uci set network.$iface='interface'
    uci set network.$iface.proto='3g'
    uci set network.$iface.service='umts'
    uci set network.$iface.device=$dev
    uci set network.$iface.apn='internet'
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
check_add_iface "Sim1" "/dev/ttyUSB3"
check_add_iface "Sim2" "/dev/ttyUSB7"
uci commit
