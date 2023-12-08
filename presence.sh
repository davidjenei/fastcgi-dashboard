#!/usr/bin/env bash

TOPICS="-t devices/# -t zigbee2mqtt/livingroom/camera"

mosquitto_sub -v $TOPICS | while IFS=' ' read topic json; do

TITLE="Presence" && source utils.sh && load_json

echo "
$HEAD_HTML
$NAV_HTML
<h1>$TITLE</h1>
<h2>Devices</h2>
`for device in ${!devices*}; do
    echo "$(cut -d '_' -f 2 <<< $device): ${!device}"
    echo "<br>"
done`
<h2>Actions</h2>
Camera: <a href="./action.cgi?camera\&presence.html">$zigbee2mqtt_livingroom_camera_state</a> <br/>
$FOOTER_HTML
$BODY_END_HTML" > $1
done
