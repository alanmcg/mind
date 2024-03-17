#!/bin/bash

# Convert markdown journal to html with pandoc and open in browser.
# CSS is taken from https://github.com/otsaloma/markdown-css - tufte version. Customized to add a basic left floated TOC
# Usage: mindreader.sh

# check if journal exists
if [ ! -s ~/.journal.md ]; then
    echo "No journal for the user: $USER found. Please start by running the 'mind' program and making a first entry!"
    exit 1
fi

# create temporary file
tmpfile=$(mktemp /tmp/tmp.XXXXXX)

pandoc -s --toc --metadata title="Welcome to the private journal of $USER" -c /home/"$USER"/.local/share/applications/mind/tufte.css ~/.journal.md >"$tmpfile"

xdg-open "$tmpfile"
sleep 5 && rm "$tmpfile"
