#!/bin/bash -x

if [ "$1" = "control-plane" ]; then
    for i in `seq 1 3`; do ssh control-plane-${i}.k8s.home.arpa "sudo reboot"; done
elif [ "$1" = "node" ]; then
    for i in `seq 1 5`; do ssh node-${i}.k8s.home.arpa "sudo reboot"; done
fi

exit 0
