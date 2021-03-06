#!/bin/bash -x

seq 1 3 | xargs -I {} -P 3 scp uninstall4control-plane.sh control-plane-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "./uninstall4control-plane.sh"
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "rm ./uninstall4control-plane.sh"
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "sync"

exit 0
