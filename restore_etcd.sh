#!/bin/bash -x

if [ $# != 1 ]; then
    exit 1
fi

SNAPSHOT_PATH=$1
SNAPSHOT_FILE=`echo $1 | awk -F '/' '{print $NF}'`

seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "sudo systemctl stop etcd"
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "sudo rm -rf /var/lib/etcd/"
seq 1 3 | xargs -I {} -P 3 scp $SNAPSHOT_PATH etcd-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa \
    "ETCDCTL_API=3 sudo etcdctl snapshot restore $SNAPSHOT_FILE \
        --cacert /etc/etcd/pki/etcd-ca.pem \
        --cert /etc/etcd/pki/etcd-peer-{}.pem \
        --key /etc/etcd/pki/etcd-peer-{}-key.pem \
        --data-dir /var/lib/etcd/ \
        --name etcd-{} \
        --initial-cluster etcd-1=https://192.168.114.11:2380,etcd-2=https://192.168.114.12:2380,etcd-3=https://192.168.114.13:2380 \
        --initial-cluster-token etcd \
        --initial-advertise-peer-urls https://192.168.114.1{}:2380"
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "rm $SNAPSHOT_FILE"
seq 1 3 | xargs -I {} -P 3 ssh etcd-{}.k8s.home.arpa "sudo systemctl start etcd"

exit 0
