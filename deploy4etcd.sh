#!/bin/bash -x

./scp4etcd.sh

seq 1 3 | xargs -I {} -P 3 scp install4etcd.sh etcd-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "./install4etcd.sh"
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "rm ./install4etcd.sh"

for i in `seq 1 3`
do 
    ssh etcd-${i}.k8s.home.arpa "sudo mv etcd-*.pem /etc/etcd/pki/"
    ssh etcd-${i}.k8s.home.arpa "sudo mv etcd.service /etc/systemd/system/"
    ssh etcd-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
    ssh etcd-${i}.k8s.home.arpa "sudo systemctl enable etcd"
done

seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "sudo systemctl start etcd"

exit 0
