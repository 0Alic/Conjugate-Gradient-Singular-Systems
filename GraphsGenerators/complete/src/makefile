CC = g++
SW = -O

OBJS = complete.o

complete: $(OBJS)
	$(CC) -o $@ $(OBJS) $(SW)

complete.o: complete.C
	$(CC) -c $*.C -o $@ $(SW)
