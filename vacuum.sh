#!/usr/bin/env bash

trap 'kill -TERM $pid' SIGTERM SIGINT

TOPICS="-t vacuum/status"

mosquitto_sub -v $TOPICS | while IFS=' ' read topic json; do

    TITLE="Vacuum" && source utils.sh && load_json

    echo "
    $HEAD_HTML
    $NAV_HTML
    <h1>$TITLE</h1>
    <h2>Status</h2>
    <pre>
    $_vacuum_status
    </pre>
    <h2>Actions</h2>
    Hover: <a href="./action.cgi?vacuumon\&vacuum.html">ON</a> | <a href="./action.cgi?vacuumoff\&vacuum.html">OFF</a> <br/>
    $FOOTER_HTML
    $BODY_END_HTML" > $1
done &
pid=$!

wait
