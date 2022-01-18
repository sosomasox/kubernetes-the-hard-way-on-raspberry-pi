#!/bin/bash -x 

for ret in `etcdctl --endpoints etcd-1.k8s.home.arpa:2379,etcd-2.k8s.home.arpa:2379,etcd-3.k8s.home.arpa:2379 --cacert certs/cert/etcd-ca.pem --cert certs/cert/etcd-healthcheck-client.pem --key certs/cert/etcd-healthcheck-client-key.pem endpoint status | tr -d ' '`
do
  if [ "`echo $ret | awk -F ',' '{print $5}'`" = "true" ]; then
    LEADER=`echo $ret | awk -F ',' '{print $1}'`
  fi
done

if [ -n "$LEADER" ]; then
  etcdctl --endpoints $LEADER --cacert certs/cert/etcd-ca.pem --cert certs/cert/etcd-healthcheck-client.pem --key certs/cert/etcd-healthcheck-client-key.pem snapshot save snapshot_`date +%Y%m%d`.db
fi

exit 0
