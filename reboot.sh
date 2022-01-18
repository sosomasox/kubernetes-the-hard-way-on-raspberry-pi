#!/bin/bash -x

for i in `seq 1 3`; do ssh control-plane-${i}.k8s.home.arpa "sudo reboot"; done
for i in `seq 1 5`; do ssh node-${i}.k8s.home.arpa "sudo reboot"; done

exit 0
