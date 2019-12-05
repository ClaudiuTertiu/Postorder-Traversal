#!/usr/bin/env python

import subprocess
import shutil
import os
import sys

runExec = "./postorder"
useShell = True

inputFileName = "input.inc"

numTests = 90
numPassed = 0

header = "======================= Postorder traversal ======================="
print("\n" + header + "\n")

if not os.path.exists(runExec):
    rc = subprocess.call("make", shell=useShell)
    if rc != 0:
        sys.stderr.write("make failed with status %d\n" % rc)
        sys.exit(rc)

if not os.path.exists(runExec):
    sys.stderr.write("The file %s is missing and could not be created with make" % runExec)
    sys.exit(-1)

for n in range(1, numTests + 1):
    shutil.copy("inputs/input" + str(n) + ".txt", inputFileName)

    proc = os.popen('./' + 'postorder < ' +  inputFileName)
    result = proc.read().strip()
    proc.close()

    expectedResult = open("outputs/output" + str(n) + ".txt").read().strip()

    if expectedResult == result:
        result = "passed"
        numPassed += 1
    else:
        result = "failed"

    start = "Test " + str(n)
    print(start + "." * (len(header) - len(result) - len(start)) + result)


os.remove(inputFileName)
