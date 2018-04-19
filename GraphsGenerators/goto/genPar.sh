#!/bin/bash

# GotoGraph Param Generator

i=1

#arcArray=(1000 2000 3000 8000 16000)
#nodeArray=(23 31 38 64 90)

arcArray=(1000 2000 3000 8000 16000 128000 512000 1000000)
nodeArray=(89 126 155 253 358 1312 2724 4028)

seed=1211;

for it in {0..7}; 
do

	arc="${arcArray[$it]}";
	node="${nodeArray[$it]}";

	while [ $i -le 15 ]
	do

		FILE="params/${arc}/${arc}(${i}).par";
		rm $FILE
		touch $FILE;
#		IN="${arc}par/${arc}-${i}complete.par";
		echo "${node} ${arc} 8 8 ${seed}";
		echo "${node} ${arc} 8 8 ${seed}" > $FILE;
		echo "$FILE done";
		i=$(( i + 1 ));
		seed=$(( seed + node ));
	done

	i=1;

done
