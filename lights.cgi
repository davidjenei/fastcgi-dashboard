#!/usr/bin/env bash

TITLE="Lights"
source html.cgi

echo "Content-type: text/html

$HEAD_HTML
$NAV_HTML
<h1>Lights</h1>
Christmas lights: <a href="./action.cgi?toggle">`state zigbee2mqtt/livingroom/xmaslight`</a>
<br/>
$FOOTER_HTML
$BODY_END_HTML"
