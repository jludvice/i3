#!/bin/bash
BASE_DIR=`pwd`

if [ "$#" -gt 1 ]; then
    echo "Illegal number of parameters"
    exit 9
fi

if [ "$#" -eq 1 ]; then
    sed -i "s#avano#$1#g" $BASE_DIR/*
fi

$BASE_DIR/i3conf.sh
