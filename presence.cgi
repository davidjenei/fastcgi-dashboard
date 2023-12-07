#!/usr/bin/env bash

DEVICES="iphone ipad iphonea"
TITLE="Presence"
source html.cgi

state(){
    mosquitto_sub -W 1 -t $1 -C 1 | jq -r '.state'
}

print_devices(){
    for _ in $DEVICES; do
	echo "${_}: `state devices/$_` <br/>" &
    done
    wait
}

echo "Content-type: text/html

$HEAD_HTML
$NAV_HTML
<h1>Presence</h1>
<h2>Devices</h2>
`print_devices`
<h2>Actions</h2>
Camera: <a href="./action.cgi?camera">`state zigbee2mqtt/livingroom/camera`</a> <br/>
$FOOTER_HTML
$BODY_END_HTML"

