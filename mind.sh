#!/bin/bash

# Record journal entries in cronological order in markdown format.

# Usage: mind.sh [-z]

while getopts ":z" option; do
    case $option in
    z)
        zenity=true
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
done
date=$(date '+%a %d %B %Y')
# date=$(date -d "tomorrow" '+%Y-%m-%d')

time=$(date '+%H:%M:%S')

entry() {
    if [ "$zenity" ]; then
        zenity_output=$(zenity --entry)
        if [[ "$zenity_output" =~ ^[[:blank:]]*$ || -z $? ]]; then
            exit 1
        else
            printf '%s\n' "$zenity_output"
        fi
    else
        while IFS="" read -r line; do
            printf '%s\n' "$line"
        done
    fi
}

if [ ! -s ~/.journal.md ]; then
    touch ~/.journal.md
    chmod 600 ~/.journal.md
fi

cp ~/.journal.md ~/.journal.md.live
{
    printf '%s\n' "### $time"
    entry
    printf '%s\n' ""
} | cat - ~/.journal.md.live >tmp.md && mv tmp.md ~/.journal.md.live

grep_status=$(
    grep -q "## Entries for $date" ~/.journal.md | tail -n 1
    echo -n $?
)
if [ "$grep_status" == 0 ]; then
    pattern="## Entries for $date"
    sed -i "/$pattern/d;1i\\$pattern" ~/.journal.md.live
fi

mv ~/.journal.md.live ~/.journal.md
