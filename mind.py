#!/usr/bin/env python

from time import time, strftime, localtime

"""
reimplimentation of the mind module from the original bash version
"""


class Main:
    def __init__(self):
        self.journal = []

    def add_entry(self, entry):
        self.journal.append(entry)

    def list_entries(self):
        for entry in self.journal:
            print("## Entry for: ", strftime("%Y-%m-%d %H:%M:%S", localtime(entry.epoch)))
            print(entry.body)


class JournalLogEntry:
    def __init__(self, body):
        self.epoch = round(time())
        self.body = body
