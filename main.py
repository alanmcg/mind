#!/usr/bin/env python3

from argparse import ArgumentParser
from mind import Main, JournalLogEntry


def main():
    parser = ArgumentParser(description="Mind Journal")
    parser.add_argument("-a", "--add", help="Add an entry to the journal", type=str)
    parser.add_argument("-l", "--list", help="List all journal entries", action="store_true")
    args = parser.parse_args()

    mind = Main()

    if args.add:
        mind.add_entry(JournalLogEntry(args.add))
        print("Entry added")
        print(mind.journal[0].body)
    elif args.list:
        mind.list_entries()
