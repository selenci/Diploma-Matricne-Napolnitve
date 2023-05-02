import random
from prestej import prestej
from zmanjsaj import zmanjsaj



def exportMatrix(matrix, fileName):
    file = open(fileName, 'w') 
    file.write("A = [ \n")
    n1 = len(matrix)
    n2 = len(matrix[0])


    for i in range(min(n1, 10000)):
        niz = ""
        for j in range(min(n2, 10000)):
            niz = niz + str(matrix[i][j]) + " "
        
        file.write(niz + "; \n")

    file.write("];\n")
    file.write("A(:, randperm(size(A, 2)));\n")

    file.write("v = sum(A)\n")
    file.write("ind = find(v < 100)\n")
    file.write("A(:,ind) = [];\n")

    file.write("v = sum(A')\n")
    file.write("ind = find(v < 100)\n")
    file.write("A(ind,:) = [];\n")

    file.write("M = A ~= 0;\n")


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





