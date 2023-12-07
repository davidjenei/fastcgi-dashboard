#!/usr/bin/env bash

TITLE="About"
source html.cgi

echo "Content-type: text/html

$HEAD_HTML
$NAV_HTML
<h1>About</h1>
Hostname: $HOSTNAME<br/>
Current date and time: $(date)<br/>
Zigbee: `state zigbee2mqtt/bridge/state`<br/>
<br/>
$FOOTER_HTML
$BODY_END_HTML"
