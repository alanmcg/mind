#!/bin/bash

# Convert markdown journal to html with pandoc and open in browser.
# CSS is taken from https://github.com/otsaloma/markdown-css - tufte version. Customized to add a basic left floated TOC
# Usage: mindreader.sh

# check if journal exists
if [ ! -s ~/.journal.md ]; then
    echo "No journal for the user: $USER found. Please start by running the 'mind' program and making a first entry!"
    exit 1
fi

mkdir -p /tmp/"$USER"
touch /tmp/"$USER"/journal.html
chmod 600 /tmp/"$USER"/journal.html

pandoc -s --toc --metadata title="Welcome to the private journal of $USER" -c /home/"$USER"/.local/share/applications/mind/tufte.css ~/.journal.md -o /tmp/"$USER"/journal.html
xdg-open /tmp/"$USER"/journal.html

sleep 2

rm /tmp/"$USER"/journal.html
