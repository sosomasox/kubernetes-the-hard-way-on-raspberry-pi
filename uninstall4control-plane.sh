#!/bin/bash -x

sudo systemctl stop \
    etcd.service \
    kube-apiserver.service \
    kube-controller-manager.service \
    kube-scheduler.service

sudo systemctl disable \
    etcd.service \
    kube-apiserver.service \
    kube-controller-manager.service \
    kube-scheduler.service

sudo rm -rf \
    /etc/etcd/ \
    /var/lib/etcd/ \
    /var/log/etcd/ \
    /etc/kubernetes/ \
    /var/lib/kubernetes/ \
    /etc/systemd/system/etcd.service \
    /etc/systemd/system/kube-apiserver.service \
    /etc/systemd/system/kube-controller-manager.service \
    /etc/systemd/system/kube-scheduler.service

exit 0
