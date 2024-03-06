#!/usr/bin/env sh

task rc.bulk=0 rc.confirmation=off rc.dependency.confirmation=off rc.recurrence.confirmation=off "${@:2}" modify $1
