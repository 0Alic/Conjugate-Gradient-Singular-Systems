#!/bin/bash

# GotoGraphGenerator

i=1

arcArray=(1000 2000 3000 8000 16000 128000 512000 1000000)
nodeArray=(89 126 155 253 358 1012 2024 2828)

for it in {0..7}; 
do

	arc="${arcArray[$it]}";
	node="${nodeArray[$it]}";

	while [ $i -le 15 ]
	do

		FILE="graphs/${arc}/${arc} (${i}).dmx";
		rm $FILE
		touch $FILE;
		IN="/params/${arc}/${arc}(${i}).par";

		./goto < "params/${arc}/${arc}(${i}).par" > "graphs/${arc}/${arc} (${i}).dmx";

		echo "$FILE done";
		i=$(( i + 1 ));
	done

	i=1;

done
