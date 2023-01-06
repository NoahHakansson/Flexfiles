#!/bin/bash

if [ $# -eq 0 ]
then
    # return actual volume when no parameter is received
    echo "$(nmcli device status | grep wifi | awk '{print $4}')"
fi
