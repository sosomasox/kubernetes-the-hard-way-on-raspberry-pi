#!/bin/bash

for i in `seq 1 3`
do
scp \
    loadbalancer/configs/keepalived.conf \
    loadbalancer/configs/haproxy.cfg \
    loadbalancer/unitfiles/keepalived.service \
    loadbalancer/unitfiles/haproxy.service \
    loadbalancer-${i}.k8s.home.arpa:
done

exit 0
