for event in /sys/class/input/event*; do
    if [ "$(cat $event/device/name)" = "xremap" ]; then
        echo "/dev/input/$(basename $event)"
    fi
done
