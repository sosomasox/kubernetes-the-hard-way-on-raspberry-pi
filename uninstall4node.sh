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
    /etc/systemd/system/kubelet.service \
    /etc/systemd/system/kube-proxy.service \
    /opt/cni/ \
    /var/lib/kubelet/

exit 0
