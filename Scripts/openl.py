#!/usr/bin/env python
import os
import sys

#
# A nice little script to check the output of a command to see if each line is
# a valid file path. Then it will format it into an easy way to open each of
# the paths.
#
# For example:
#   > locate .gitconfig | openl.py
#
#   [0]    cancel
#   [1] all
#   [2] /Users/Davis/.gitconfig
#   Which file(s) to open?:
#

#
# TODO:
#   Add docopt module
#   Add better path resolving
#   Change to run arguments (not accept from stdin)
#


def launch(line):
    os.system('open "{0}"'.format(line))


def main():
    if len(sys.argv) > 1:
        file_name = sys.argv[1]
        try:
            print file_name
            reader = open(file_name)
        except:
            print 'File {0} not found'.format(file_name)
            return 1
    else:
        reader = sys.stdin

    input_lines = reader.readlines()
    reader.close()

    sys.stdin = open('/dev/tty')

    lines = []

    for n, line in enumerate(input_lines):
        line = line.rstrip('\n')
        if os.path.exists(os.path.abspath(line)):
            if n == 0:
                print '[0]\tcancel\n[1]	all'

            print '[{0}]\t{1}'.format(n + 2, line)

            lines.append(line)

    if len(lines) == 0:
        print 'No files found in the input.'
        return 1

    to_open = raw_input('Which file(s) to open?: ').split(',')

    while True:
        if '1' in to_open:
            for line in lines:
                launch(line)
        else:
            for i in to_open:
                try:
                    i = int(i)
                except:
                    print 'Exception'
                    continue

                if 0 < i < len(lines) + 1:
                    launch(lines[i - 2])

        return 1

if __name__ == '__main__':
    sys.exit(main())
