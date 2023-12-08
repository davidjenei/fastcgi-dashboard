#!/usr/bin/env bash

TOPICS="-t zigbee2mqtt/bridge/state"

mosquitto_sub -v $TOPICS | while IFS=' ' read topic json; do

TITLE="About" && source utils.sh && load_json

echo "
$HEAD_HTML
$NAV_HTML
<h1>$TITLE</h1>
Hostname: $HOSTNAME<br/>
Zigbee: $zigbee2mqtt_bridge_state_state
<br/>
$FOOTER_HTML
$BODY_END_HTML" > $1

done
