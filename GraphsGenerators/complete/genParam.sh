#!/bin/bash

i=1

iterArray=(0 1 2)
arcArray=(128000 512000 1000000)
#nodeArray=(23 31 38 64 90)
nodeArray=(337 759 1060)

seed=16807;

for it in "${iterArray[@]}" 
do

	arc="${arcArray[$it]}";
	node="${nodeArray[$it]}";

	while [ $i -le 25 ]
	do

		FILE="${arc}par/${arc}-${i}complete.par";
		rm $FILE
		touch $FILE;

		i=$(( i + 1 ));
		echo -e "${node}" >> $FILE;
		echo -e "2" >> $FILE;
		echo -e "100" >> $FILE;
		echo -e "2" >> $FILE;
		echo -e "100" >> $FILE;
		echo -e "5" >> $FILE;
		echo -e "20" >> $FILE;
		echo -e "400" >> $FILE;
		echo -e "${seed}" >> $FILE;

		seed=$(( seed + node ));
	done

	i=1;

done
