#!/bin/bash

for i in `seq 1 3`
do
scp \
    certs/cacert/etcd-ca.pem \
    certs/cert/etcd-${i}.pem \
    certs/cert/etcd-${i}-key.pem \
    certs/cert/etcd-peer-${i}.pem \
    certs/cert/etcd-peer-${i}-key.pem \
    unitfiles/etcd/etcd-${i}/etcd.service \
    etcd-${i}.k8s.home.arpa:
done

exit 0
