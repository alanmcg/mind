#!/bin/bash

# Record journal entries in cronological order in markdown format.

# Usage: mind.sh [-z]

while getopts ":z" option; do
    case $option in
    z)
        z=true
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
done
date=$(date '+%a %d %B %Y')
time=$(date '+%H:%M:%S')

if [ ! -s ~/.journal.md ]; then
    printf '%s\n' "# Welcome" >>~/.journal.md
fi

cp ~/.journal.md ~/.journal.md.live
{
    if [ "$(grep "## Entries for $date" ~/.journal.md | tail -n 1)" ]; then
        printf '%s\n' ""
        printf '%s\n' "### $time"
        if [ "$z" ]; then
            zenity --entry
        else
            while IFS="" read -r line; do
                printf '%s\n' "$line"
            done
        fi
    else
        printf '%s\n' ""
        printf '%s\n' "## Entries for $date"
        printf '%s\n' "### $time"
        if [ "$z" ]; then
            zenity --entry
        else
            while IFS="" read -r line; do
                printf '%s\n' "$line"
            done
        fi
    fi
} >>~/.journal.md.live
mv ~/.journal.md.live ~/.journal.md
