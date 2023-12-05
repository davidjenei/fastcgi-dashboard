#!/usr/bin/env bash

TITLE="Presence"
source html.cgi

state(){
    mosquitto_sub -W 1 -t $1 -C 1 | jq -r '.state'
}

echo "Content-type: text/html

$HEAD_HTML
$NAV_HTML
<h1>Presence</h1>
<h2>Devices</h2>
phone: `state devices/iphone`<br/>
tablet: `state devices/ipad`<br/>
Anda phone: `state devices/iphonea`<br/>
<br/>
$FOOTER_HTML
$BODY_END_HTML"

