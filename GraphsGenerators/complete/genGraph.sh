#!/bin/bash

i=1

iterArray=(0 1 2)
#arcArray=(1000 2000 3000 8000 16000)
#nodeArray=(23 31 38 64 90)

arcArray=(128000 512000 1000000)
nodeArray=(337 759 1060)


seed=16807;

for it in "${iterArray[@]}" 
do

	arc="${arcArray[$it]}";
#	node="${nodeArray[$it]}";

	while [ $i -le 25 ]
	do

		FILE="${arc}/${arc}(${i}).dmx";
		rm $FILE
		touch $FILE;
		IN="${arc}par/${arc}-${i}complete.par";

		echo $IN;
		./src/complete $FILE < $IN;
		echo "$FILE done";
		i=$(( i + 1 ));
	done

	i=1;

done
