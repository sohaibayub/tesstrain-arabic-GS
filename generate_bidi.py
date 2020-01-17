#!/usr/bin/env python3

import argparse
import io
import unicodedata
import bidi.algorithm

#
# command line arguments
#
arg_parser = argparse.ArgumentParser('''Reverse RTL text''')

# Text ground truth
arg_parser.add_argument('-t', '--txt', nargs='?', metavar='TXT', help='RTL text (GT)', required=True)

args = arg_parser.parse_args()

#
# main
#

# load gt
with io.open(args.txt, "r", encoding='utf-8') as f:
    lines = f.read().strip().split('\n')

# create WordStr line boxes for Indic & RTL
for line in lines:
    line = unicodedata.normalize('NFC', line.strip())
    line = bidi.algorithm.get_display(line)
    if line:
        print(line)
