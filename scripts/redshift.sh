#!/bin/bash

if [ "$1" == 'toggle' ]; then
	pidof redshift > /dev/null && killall redshift && exit 0
	pidof redshift > /dev/null || nohup redshift -l geoclue2 &> /dev/null &
else
	pidof redshift > /dev/null && echo "On"
	pidof redshift > /dev/null || echo "Off"
fi

