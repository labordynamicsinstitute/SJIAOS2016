#!/bin/bash

for arg in $(ls ../table*tex)
do
	sed 's+results/+../results/+;s/jobcreation/jc-/' $arg > $(basename $arg)
done
