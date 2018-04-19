#!/bin/bash

i=1

arcArray=(128000 512000 1000000)
rhoArray=(1 2 3)

for arc in "${arcArray[@]}"
do
	for rho in "${rhoArray[@]}"
	do
		while [ $i -le 10 ]
		do
			./pargen $arc $rho $i a a ns
			mv "netgen-$arc-$rho-$i-a-a-ns.par" "${arc}par";
			echo "netgen-$arc-$rho-$i-a-a-ns.par CREATED";
			i=$(( i + 1 ));
		done
		i=1;
	done
done
