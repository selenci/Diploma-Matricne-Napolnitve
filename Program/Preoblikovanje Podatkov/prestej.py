from typing import Tuple
from typing import Dict


def prestej(fileName) -> Tuple[Dict[str, int], Dict[str, int]]:

    file = open(fileName, 'r')
    nVals = {}
    mVals = {}

    i = 0
    j = 0

    while True:
       
    
        line = file.readline()
        if not line:
            break

        nums = line.strip().split(" ")
        if nums[0] not in nVals:
            nVals[nums[0]] = i
            i += 1

        if nums[1] not in mVals:
            mVals[nums[1]] = j
            j += 1

    file.close()
        
    return (nVals, mVals)