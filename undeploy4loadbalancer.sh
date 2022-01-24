#!/bin/bash -x

seq 1 3 | xargs -I {} -P 3 scp uninstall4loadbalancer.sh loadbalancer-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh loadbalancer-{}.k8s.home.arpa "./uninstall4loadbalancer.sh"
seq 1 3 | xargs -I {} -P 3 ssh loadbalancer-{}.k8s.home.arpa "rm ./uninstall4loadbalancer.sh"
seq 1 3 | xargs -I {} -P 3 ssh loadbalancer-{}.k8s.home.arpa "sync"

exit 0
