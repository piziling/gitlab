#!/bin/bash

if [[ $# -eq 0 ]]
then
	echo Error : please input

elif [[ $# -eq 1 ]]
then
	docker exec -it $(docker ps | grep $1 | awk '{print $1}') /bin/bash
else
	docker exec -it $(docker ps | grep $1 | awk '{print $1}') ${@:2}
fi