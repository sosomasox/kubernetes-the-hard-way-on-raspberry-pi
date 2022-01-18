#!/bin/bash -x

for i in `seq 1 3`
do
    scp uninstall4node.sh control-plane-${i}.k8s.home.arpa:
    ssh control-plane-${i}.k8s.home.arpa "./uninstall4node.sh"
done
for i in `seq 1 5`
do
    scp uninstall4node.sh node-${i}.k8s.home.arpa:
    ssh node-${i}.k8s.home.arpa "./uninstall4node.sh"
done

exit 0
