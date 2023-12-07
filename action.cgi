#!/usr/bin/env bash

source html.cgi

case "$QUERY_STRING" in
  "toggle")
    toggle 'zigbee2mqtt/livingroom/xmaslight' && LOCATION="/lights.cgi"
    ;;
  "camera")
    toggle 'zigbee2mqtt/livingroom/camera' && LOCATION="/presence.cgi"
    ;;
esac

echo "Status: 302 Found"
echo "Location: ${LOCATION}"
echo "Content-type: text/html"
echo

