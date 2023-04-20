import random
from typing import Tuple
from typing import Dict


def zmanjsaj(inputFile, outputFile, chance):

    fileIn = open(inputFile, 'r')
    fileOut = open(outputFile, 'w')

    while True:
       
    
        line = fileIn.readline()
        if not line:
            break

        if random.random() > chance:
            continue
        fileOut.write(line)
        