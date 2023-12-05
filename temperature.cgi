#!/usr/bin/env bash

TITLE="Temperature"
source html.cgi

# FIXME: Print data in table
IFS=$'\t' read -r hw_temp hw_hum <<< \
	`mosquitto_sub -t 'zigbee2mqtt/hallway/temp' -C 1 | jq -r '[.temperature, .humidity] | @tsv'`

IFS=$'\t' read -r living_temp living_hum <<< \
	`mosquitto_sub -t 'zigbee2mqtt/livingroom/temp' -C 1 | jq -r '[.temperature, .humidity] | @tsv'`


echo "Content-type: text/html

$HEAD_HTML
$NAV_HTML
<h1>Temperature</h1>
<h2>Hallway</h2>
Hallway temperature: ${hw_temp} °C<br/>
Hallway humidity: ${hw_hum} %<br/>
<h2>Living room</h2>
Living room temperature: ${living_temp} °C<br/>
Living room humidity: ${living_hum} %<br/>
<br/>
$FOOTER_HTML
$BODY_END_HTML"

