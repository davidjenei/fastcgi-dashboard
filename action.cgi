#!/usr/bin/env bash

toggle(){
    mosquitto_pub -t "$1/set" -m '{"state": "TOGGLE"}'
}

wait_until(){
    while :; do
	LAST_MODIFIED=`stat -c %Y /static/${location}`
	test $LAST_MODIFIED -lt `printf "%.0f" $REQUEST_TIME` && sleep 0.1 || break;
    done
}

IFS='&' read -r cmd location topic <<< "$QUERY_STRING"

case "$cmd" in
  "toggle")
    toggle "zigbee2mqtt/livingroom/xmaslight" && wait_until
    ;;
  "camera")
    toggle 'zigbee2mqtt/livingroom/camera' && wait_until
    ;;
esac

echo "Status: 302 Found"
echo "Location: $location?$topic"
echo "Content-type: text/html"
echo

