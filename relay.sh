#!/bin/bash
BASEPORT=${1:-9000}
PAIRS=${2:-10}
trap "pkill -P $$ --signal 9" EXIT
for (( COUNTER=0; COUNTER<=PAIRS; COUNTER+=1 )); do
    EVEN=$((BASEPORT + COUNTER * 2))
    ODD=$((EVEN+1))
    echo Forwarding between port $EVEN-$ODD
    socat udp-listen:$EVEN,reuseaddr udp-listen:$ODD,reuseaddr &
done
wait
