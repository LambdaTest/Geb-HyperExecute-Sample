#!/usr/bin/env bash
while read config
do
    echo "$config" $1
done < capabilities
