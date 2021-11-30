#!/bin/python3

# GENERATE SEGFAULT TYPE 3

import os, itertools
import multiprocessing as mp

def f(n,quit,foundit):
    for i in itertools.count():
        if not quit.is_set():
            stream = os.popen('cat orig.cue | radamsa > ram' + str(n) + '.cue ; flacon -s ram' + str(n) + '.cue 2>&1')
            output = stream.read()
            err = output.split('\n')[-3:-1]
            if 'SUMMARY' in err[0] and not 'audioFiles' in err[0]:
                print('\nTHREAD: ' + str(n) + '\n\n' + output)
                foundit.set()
                break
            else: 
                print('\rTHREAD: ' + str(n) + '\tRUN ' + str(i) + ': '+ err[1].replace('\n', ' '))
        else:
            break

if __name__ == "__main__":
    quit = mp.Event()
    foundit = mp.Event()
    for i in range(mp.cpu_count()):
        p = mp.Process(target=f, args=(i, quit, foundit))
        p.start()
    foundit.wait()
    quit.set()
