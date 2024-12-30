#!/bin/sh

if eww active-windows | grep $1; then
    eww close $1
    eww close $1_closer
else
    eww open $1_closer
    eww open $1
fi
