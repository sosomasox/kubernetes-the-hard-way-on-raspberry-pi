#!/bin/bash -x

seq 1 3 | xargs -I {} -P 3 scp uninstall4node.sh control-plane-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "./uninstall4node.sh"

seq 1 5 | xargs -I {} -P 5 scp uninstall4node.sh node-{}.k8s.home.arpa:
seq 1 5 | xargs -I {} -P 5 ssh node-{}.k8s.home.arpa "./uninstall4node.sh"

exit 0
