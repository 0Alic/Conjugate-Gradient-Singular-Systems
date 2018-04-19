import glob
import os

def generateE(file_name):
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

    # Write matrix in a file
    file_loc = file_name[:-4] + "_E"
    file_loc = file_loc.replace("dmx", "E")
    outfile = open(file_loc, "w")
    column = 1
    for line in file_graph:
        if line[0] == 'a':
            array = line.split()
            outfile.write(str(int(array[1]))+" "+str(column)+" 1")
            outfile.write("\n")
            outfile.write(str(int(array[2]))+" "+str(column)+" -1")
            outfile.write("\n")
            column += 1
    outfile.close()
    ##############
    return column


##################
# Run the function

#for all kind of generators
for generator in os.listdir("../Data"):
    #for all sizes
    for nEdges in os.listdir("../Data/"+generator):
        nGraphs = len(glob.glob1("../Data/"+generator+"/" + str(nEdges)+"/dmx", "*.dmx"))
        #for each instance
        for i in range(nGraphs):
            print "Computing "+ generator +" "+ str(nEdges) + " number " + str(i + 1)
            generateE("../Data/" + generator + "/" + str(nEdges) + "/dmx/" + str(nEdges) + " (" + `i + 1` + ").dmx")