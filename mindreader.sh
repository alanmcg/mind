#!/bin/bash

# Convert markdown journal to html with pandoc and open in browser.
# CSS is taken from https://github.com/otsaloma/markdown-css - tufte version. Customized to add a basic left floated TOC
# Usage: mindreader.sh

# check if journal exists
if [ ! -s ~/.journal.md ]; then
    echo "No journal for the user: $USER found. Please start by running the 'mind' program and making a first entry!"
    exit 1
fi

# create temporary directory
tmpfile=$(mktemp -d /tmp/mindreader.XXXXXX)
cp /home/"$USER"/.local/share/applications/mind/tufte.css "$tmpfile/tufte.css"
pandoc --toc --metadata title="Welcome to the private journal of $USER" -H "$tmpfile"/tufte.css ~/.journal.md >"$tmpfile"/index.html

cd "$tmpfile" || exit
python3 -m http.server 8082 &

xdg-open http://localhost:8082/

sleep 3 && rm -rf "$tmpfile" && kill $! 2>/dev/null

# sleep 5 && rm -rf "$tmpfile"
