import random
import os
import glob

def generateD (file_name, non_zeros): #non_zeros is a value [0-1]
    #read file
    file_graph = open(file_name, "r")
    flag = False
    while not flag:
        line = file_graph.readline()
        if line[0] == 'p':
            data = line.split()
            n = data[2]
            m = data[3]
            flag = True

    #check the input
    if non_zeros < 0:
        non_zeros = 0
    if non_zeros > 1:
        non_zeros = 1

    # Write matrix in a file
    file_loc = file_name[:-4] + "_" + str(int(non_zeros*100))
    file_loc = file_loc.replace("dmx", "D")
    outfile = open(file_loc, "w")
    #big_val = random.randint(2 * int(n), 3 * int(n))
    for edge in range(int(m)):
        coin = random.random()
        val = random.random()
        if coin < non_zeros:
            val = pow(((1-non_zeros)*100), 2)*val + val
        else:
            val = val/(pow(10,(5-int(non_zeros*10)/2)))
        outfile.write(str(edge + 1) + " " + str(edge+1) + " " + str(val))
        outfile.write("\n")
    outfile.close()

##################
# Run the function

#for all kind of generators
for density in [0.25, 0.75]:
    for generator in os.listdir("../Data"):
        # for all sizes
        for nEdges in os.listdir("../Data/"+generator):
            nGraphs = len(glob.glob1("../Data/"+generator+"/" + str(nEdges) + "/dmx", "*.dmx"))
            #for each instance
            for i in range(nGraphs):
                print "Computing "+ generator +" "+ str(nEdges) + " number " + str(i + 1)
                generateD("../Data/" + generator + "/" + str(nEdges) + "/dmx/" + str(nEdges) + " (" + `i + 1` + ").dmx", density)
