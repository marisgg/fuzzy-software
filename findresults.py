import os, sys
import subprocess
from multiprocessing import Pool


def f(input):
    p = subprocess.Popen(f'FLACON_DEBUG=1 flacon_with_asan_compile/flacon -s {input}', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    p.wait()
    output = bytes.decode(p.stderr.read())
    # print(output)
    output2 = bytes.decode(p.stdout.read())
    # print(output2)
    if 'AudioFileMatcher::audioFiles(int) const' not in output and 'AudioFileMatcher::audioFiles(int) const' not in output2:
    	print(output)
    	print(output2)
    # if 'audioFiles(int) const' not in output:
        # print(bytes.decode(p.stdout.read()))
        # print(input)
        # print(output)

with Pool(4) as pool:
    inputs = [os.path.join(f'{sys.argv[1]}/{dir}/crashes/', x) for dir in ['pMSAN'] for x in os.listdir(f'{sys.argv[1]}/{dir}/crashes/')]
    pool.map(f, inputs)

# for dir in ['main', 'p1', 'p2', 'p3']:
    # for input in os.listdir(f'parallel/{dir}/crashes/'):
        # if input == "README.txt":
        	# continue

