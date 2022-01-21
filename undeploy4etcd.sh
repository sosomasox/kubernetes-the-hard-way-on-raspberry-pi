#!/bin/bash -x

seq 1 3 | xargs -I {} -P 3 scp uninstall4etcd.sh etcd-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "./uninstall4etcd.sh"

exit 0

