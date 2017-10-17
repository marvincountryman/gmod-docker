#!/bin/bash

while true; do
    /gmod/srcds_run -game garrysmod -norestart \
        -port ${CPORT} \
        +map ${CMAP} \
        +hostname ${CHOSTNAME} \
        +gamemode ${CGAMEMODE} \
        +maxplayers ${CMAXPLAYERS}
done