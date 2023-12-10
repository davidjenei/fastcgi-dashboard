#!/usr/bin/env bash

trap 'kill -TERM $pid' SIGTERM SIGINT

TOPICS="-t zigbee2mqtt/bridge/state"

mosquitto_sub -v $TOPICS | while IFS=' ' read topic json; do

    TITLE="About" && source utils.sh && load_json

    echo "
    $HEAD_HTML
    $NAV_HTML
    <h1>$TITLE</h1>
    <h2>Status</h2>
    Hostname: $HOSTNAME<br/>
    System: `uname -a`<br/>
    Started: `stat /proc/1 | grep "Access:" | tail -n 1 | cut -d' ' -f2- | cut -d'.' -f1`<br/>
    Zigbee gateway: $zigbee2mqtt_bridge_state_state<br/>
    <h2>About this website</h2>
    This a minimal dashboard for home automation. Uses:
    <ul>
    <li>zigbee2mqtt to collect sensor data</li>
    <li>mosquitto mqtt broker</li>
    <li>bash scripts to generate static pages</li>
    <li>fcgiwrap to handle user actions</li>
    </ul>
    $FOOTER_HTML
    $BODY_END_HTML" > $1

done &
pid=$!

wait
