#!/usr/bin/env bash
while read config
do
    echo "Running config $config"
    mvn -Dlambdageb.capabilities="$config" clean test -Dtest=$1 &
done < capabilities
