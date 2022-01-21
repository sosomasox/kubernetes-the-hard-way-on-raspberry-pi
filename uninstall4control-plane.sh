#!/bin/bash -x

sudo systemctl stop \
    kube-apiserver.service \
    kube-controller-manager.service \
    kube-scheduler.service

sudo systemctl disable \
    kube-apiserver.service \
    kube-controller-manager.service \
    kube-scheduler.service

sudo rm -rf \
    /etc/kubernetes/ \
    /var/lib/kubernetes/ \
    /etc/systemd/system/kube-apiserver.service \
    /etc/systemd/system/kube-controller-manager.service \
    /etc/systemd/system/kube-scheduler.service

exit 0
