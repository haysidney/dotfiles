#!/bin/bash

random() {
        tail -c 2 /dev/random | od -t u2 | grep 0000000 | xargs -n1 echo | tail -n +2
}

waitForX() {
        echo waiting for $1
        while [[ ! -e /tmp/.X11-unix/$1 ]]; do
                sleep 1
        done
}

DISPLAY=$(random)
while [[ -e /tmp/.X11-unix/X$DISPLAY ]]; do
        DISPLAY=$(random)
done

XDISPLAY=X$DISPLAY
DISPLAY=:$DISPLAY

echo $DISPLAY

PID=$$

#export RUST_LOG=debug

xwayland-satellite $DISPLAY &
#xwayland-satellite $DISPLAY > "$HOME/.bin/xwayland-satellite-run-log.txt" 2>&1 &

waitForX "$XDISPLAY" && DISPLAY=$DISPLAY "$@"

kill %1
