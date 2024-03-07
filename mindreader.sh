#!/bin/bash

# Convert markdown journal to html with pandoc and open in browser.
# CSS is taken from https://github.com/otsaloma/markdown-css - tufte version. Customized to add a basic left floated TOC
# Usage: mindreader.sh

# check if journal exists
if [ ! -s ~/.journal.md ]; then
    echo "No journal for the user: $USER found. Please start by running the 'mind' program and taking down your thoughts"
    exit 1
fi

mkdir -p /tmp/"$USER"
touch /tmp/"$USER"/journal.html
chmod 600 /tmp/"$USER"/journal.html

cp css/tufte.css /tmp/"$USER"/journal.css

pandoc -s --toc --metadata title="The private journal of $USER" -c /tmp/"$USER"/journal.css ~/.journal.md -o /tmp/"$USER"/journal.html
xdg-open /tmp/"$USER"/journal.html

sleep 2

rm /tmp/"$USER"/journal.html
rm /tmp/"$USER"/journal.css
