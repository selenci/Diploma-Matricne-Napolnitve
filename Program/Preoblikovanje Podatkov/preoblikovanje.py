import random
from prestej import prestej
from zmanjsaj import zmanjsaj



def exportMatrix(matrix, fileName):
    file = open(fileName, 'w') 
    file.write("A = [ \n")
    n1 = len(matrix)
    n2 = len(matrix[0])
    for vrstica in matrix:
        for element in vrstica:
            file.write(str(element) + " ")
        file.write("; \n")

    file.write("];\n")
    file.write("M = A ~= 0;")
    file.close()

fileName = 'rec-eachmovie.edges'

zmanjsaj(fileName, "min-" + fileName, 1)


(n, m) = prestej("min-" + fileName)
print(len(n) * len(m))

matrix = [[0 for x in range(len(m))] for y in range(len(n))] 

file = open("min-" + fileName, 'r') 

while True:
 
    line = file.readline()
 
    if not line:
        break

    nums = line.strip().split(" ")

    i = n[nums[0]]
    j = m[nums[1]]

    matrix[i][j] = nums[2]

file.close()

exportMatrix(matrix, "result.m")





