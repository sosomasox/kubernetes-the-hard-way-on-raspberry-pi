#!/bin/bash -x

if [ "$1" = "control-plane" ]; then
    seq 1 3 | xargs -I {} -P 3 scp uninstall4node.sh control-plane-{}.k8s.home.arpa:
    seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "./uninstall4node.sh"
    seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "rm ./uninstall4node.sh"
    seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "sync"
else
    seq 1 7 | xargs -I {} -P 7 scp uninstall4node.sh node-{}.k8s.home.arpa:
    seq 1 7 | xargs -I {} -P 7 ssh node-{}.k8s.home.arpa "./uninstall4node.sh"
    seq 1 7 | xargs -I {} -P 7 ssh node-{}.k8s.home.arpa "rm ./uninstall4node.sh"
    seq 1 7 | xargs -I {} -P 7 ssh node-{}.k8s.home.arpa "sync"
fi

exit 0
