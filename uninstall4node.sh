#!/bin/bash -x

sudo systemctl stop \
    kubelet.service \
    kube-proxy.service

sudo systemctl disable \
    kubelet.service \
    kube-proxy.service

sudo rm -rf \
    /etc/cni/ \
    /etc/containerd/ \
    /etc/kubelet/ \
    /etc/kube-proxy/ \
    /opt/cni/ \
    /var/lib/kubelet/ \
    /var/lib/kube-proxy/ \
    /var/lib/kubernetes/ \
    /etc/systemd/system/kubelet.service \
    /etc/systemd/system/kube-proxy.service

exit 0
