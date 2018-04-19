import random
import os
import glob

def generateB(file_name):
    #read file
    file_graph = open(file_name, "r")
    flag = False
    while not flag:
        line = file_graph.readline()
        if line[0] == 'p':
            data = line.split()
            n = data[2]
            flag = True

    # Write matrix in a file
    file_loc = file_name[:-4] + "_b"
    file_loc = file_loc.replace("dmx", "b")
    outfile = open(file_loc, "w")
    for i in range(int(n)):
        val = random.randint(-10, 10)
        outfile.write(str(val))
        outfile.write("\n")
    outfile.close()

##################
# Run the function

#for all kind of generators
for generator in os.listdir("../Data"):
    #for all sizes
    for nEdges in os.listdir("../Data/"+generator):
        nGraphs = len(glob.glob1("../Data/"+generator+"/" + str(nEdges) + "/dmx", "*.dmx"))
        #for each instance
        for i in range(nGraphs):
            print "Computing "+ generator +" "+ str(nEdges) + " number " + str(i + 1)
            generateB("../Data/" + generator + "/" + str(nEdges) + "/dmx/" + str(nEdges) + " (" + `i + 1` + ").dmx")