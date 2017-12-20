#!/usr/bin/env python3
""" python script to replace config parameters """

import os
import sys

# read call parameters
FD = sys.argv[1]
KEYWORD = sys.argv[2]
ENV = {}


# open the config for reading
try:
    CONFIGFILE = open(FD)
except IOError:
    exit(1)

# read the environment variables that match
for i in sorted(os.environ):
    if KEYWORD in i:
        y = os.environ[i]
        ENV(i:y)

# find and replace in the config file
for i in CONFIGFILE:
    if KEYWORD in i:
        line = i


print(ENV)
