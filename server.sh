#!/bin/bash

PORT='2222'

echo $(ip route get 1.2.3.4 | awk '{print $7}')

while true;
do
	nc -lkp $PORT
	sleep 1
done

