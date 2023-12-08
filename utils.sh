#!/usr/bin/env bash

load_json(){
while IFS= read -r key; do
  var_name="`tr '/' '_' <<< $topic`_${key}"
  eval "${var_name}"="`jq -c -r ".$key" <<< $json`"
done <<< "`jq -r 'keys[]' <<< $json`"
}

HEAD_HTML=$(cat << EOF
<!doctype html>
<html lang="en" id="top">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="icon" href="data:,">
  <link rel="stylesheet" href="style.css">
  <title>${TITLE} - davidjenei.com</title>
</head>
<body>
EOF
)

NAV_HTML=$(cat << EOF
<nav>
  <a href="#menu">Menu &ShortDownArrow;</a>
</nav>
EOF
)

BODY_END_HTML=$(cat << EOF
</body>
</html>
EOF
)

FOOTER_HTML=$(cat << EOF
<footer>
  <hr>
  <h3 id="menu">Navigation</h3>
    <ul>
      <li> <a href="./index.html">About</a> </li>
      <li> <a href="./presence.html">Presence</a> </li>
      <li> <a href="./temperature.html">Temperature</a> </li>
      <li> <a href="./lights.html">Lights</a> </li>
      <li> <a href="#top">Back to top &uarr;</a>
    </ul>
  <small>
    Last updated: `date`
    <br>
    The content for this site is
    <a href=
     "http://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a>.
    <br>
    The <a href="https://github.com/davidjenei/fastcgi-dashboard">code for this site</a> is
    <a href="https://github.com/davidjenei/davidjenei.com/blob/main/LICENSE">MIT</a>.
    <br>
    Made with bash, fcgiwrap
    and
    <a href="https://www.zigbee2mqtt.io">zigbee2mqtt</a>.
    Inspired by <a href="https://git.sr.ht/~bt/barf">barf</a>.
  </small>
</footer>
EOF
)


