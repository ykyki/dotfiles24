#!/bin/zsh

# for i in {1..10}; do time -p zsh -ic exit; done
for i in {1..10}; do
    time_output=$( { time -p zsh -ic exit; } 2>&1 )
    echo $time_output | awk '{printf "%s ", $0} END {print ""}'
done
