#!/bin/bash

i=1
c=1

arcArray=(128000 512000 1000000)
rhoArray=(1 2 3)


for arc in "${arcArray[@]}"
do
	for rho in "${rhoArray[@]}"
	do
		while [ $i -le 10 ]
		do
			./netgen < "${arc}par/netgen-$arc-$rho-$i-a-a-ns.par" > "./$arc/$arc ($c).dmx" 
			echo "$arc ($c).dmx CREATED";
			i=$(( i + 1 ));
			c=$(( c + 1));
		done
		i=1;
	done
	c=1;
done
