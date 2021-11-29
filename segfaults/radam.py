#!/bin/python3

import os, itertools

output = ""
for i in itertools.count():
    stream = os.popen('cat orig.cue | radamsa > ram.cue ; flacon -s ram.cue 2>&1')
    output = stream.read()
    out = output.split('\n')[-2]
    if 'Segmentation' in out:
        break
    else:
        print('\rRUN ' + str(i) + ': '+ out.replace('\n', ' '))

print('\n' + output)
