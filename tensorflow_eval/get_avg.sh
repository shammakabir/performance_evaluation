#!/bin/bash


grep "examples/sec" $1 | awk '{ print $8 }' | sed 's/(//g' | awk '{ total += $1 } END { print total/NR}'

