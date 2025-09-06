#!/usr/bin/env python

from datetime import datetime, timedelta
from time import sleep
import subprocess
from os import path, mkdir
from sys import argv, stderr



FILE_PATH = path.dirname(path.realpath(__file__)) + '/worked-files/'
UPTIME_FORMAT = '%Y-%m-%d %H:%M:%S\n'
FILE_NAME_FORMAT = '%Y-%m-%d'
OUTPUT_FORMAT = '%H:%M'

RUNNING_PREFIX = '%{u#00dd00}%{+u}%{F#00dd00}󰥔%{F-} '
STOPPED_PREFIX = '%{u#dd0000}%{+u}%{F#dd0000}󱡣%{F-} '



def initialize():
    if not path.isdir(FILE_PATH):
        try:
            mkdir(FILE_PATH)
        except Exception as e:
            print(f'An error occurred: {e}', file=stderr)

    current_date = datetime.today().strftime(FILE_NAME_FORMAT)

    entries = []

    file_path = FILE_PATH + current_date

    if path.isfile(file_path):
        with open(FILE_PATH + current_date, 'r') as file:
            entries = file.readlines()

    if len(entries) == 0:
        with open(FILE_PATH + current_date, 'w') as file:
            start_timestamp = subprocess.check_output('uptime -s', shell=True, encoding='UTF-8')

            file.write(start_timestamp)
            entries.append(start_timestamp)

    return (file_path, entries)



def calculate(entries):
    entry_number = len(entries)

    if entry_number % 2 == 0:
        total_time = timedelta()
        status = False
    else:
        total_time = datetime.now() - datetime.strptime(entries.pop(entry_number-1), UPTIME_FORMAT)
        status = True

    for i in range(1, entry_number, 2):
        total_time = total_time + (datetime.strptime(entries[i], UPTIME_FORMAT) - datetime.strptime(entries[i-1], UPTIME_FORMAT))

    base_date = datetime(1, 1, 1)

    return (status, (base_date + total_time).strftime(OUTPUT_FORMAT))



def new_entry(file_path, entries):
    with open(file_path, 'a') as file:
        timestamp = datetime.now().strftime(UPTIME_FORMAT)

        file.write(timestamp)

        entries.append(timestamp)



def format(time):
    return (RUNNING_PREFIX if time[0] else STOPPED_PREFIX) + '%{T0}' + time[1] + '%{T-}%{u-}'



if __name__ == '__main__':
    (file_path, entries) = initialize()

    if len(argv) > 1 and argv[1] == 'new-entry':
        new_entry(file_path, entries)

    print(format(calculate(entries)))
