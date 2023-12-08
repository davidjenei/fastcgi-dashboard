#!/usr/bin/env bash

TOPIC="zigbee2mqtt/livingroom/xmaslight"

mosquitto_sub -v -t $TOPIC | while IFS=' ' read topic json; do

TITLE="Lights" && source utils.sh

echo "
$HEAD_HTML
$NAV_HTML
<h1>$TITLE</h1>
<h2>Christmas</h2>
Status: <a href="./action.cgi?toggle\&lights.html">`jq -r '.state' <<< "$json"`</a>
<br>
Link: `jq -r '.linkquality' <<< "$json"`
<br>
$FOOTER_HTML
$BODY_END_HTML" > $1
done
