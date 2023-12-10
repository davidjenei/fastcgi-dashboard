#!/usr/bin/env bash

trap 'kill -TERM $pid' SIGTERM SIGINT

TOPICS="-t zigbee2mqtt/livingroom/temp -t zigbee2mqtt/hallway/temp"

mosquitto_sub -v $TOPICS | while IFS=' ' read topic json; do

    TITLE="Temperature" && source utils.sh && load_json

    echo "
    $HEAD_HTML
    $NAV_HTML
    <h1>$TITLE</h1>
    <h2>Hallway</h2>
    Hallway temperature: ${zigbee2mqtt_hallway_temp_temperature} °C<br/>
    Hallway humidity: ${zigbee2mqtt_hallway_temp_humidity} %<br/>
    <h2>Living room</h2>
    Living room temperature: ${zigbee2mqtt_livingroom_temp_temperature} °C<br/>
    Living room humidity: ${zigbee2mqtt_livingroom_temp_humidity} %<br/>
    <br/>
    $FOOTER_HTML
    $BODY_END_HTML" > $1

done &
pid=$!

wait
