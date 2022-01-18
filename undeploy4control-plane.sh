#!/bin/bash -x

for i in `seq 1 3`
do
    scp uninstall4control-plane.sh control-plane-${i}.k8s.home.arpa:q
    ssh control-plane-${i}.k8s.home.arpa "./uninstall4control-plane.sh"
done

exit 0

