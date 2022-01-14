#!/bin/bash

for i in `seq 1 3`
do
    scp \
        certs/cert/kubernetes-ca.pem \
        certs/cert/kubernetes-front-proxy-ca.pem \
        certs/cert/control-plane-${i}.pem \
        certs/cert/control-plane-${i}-key.pem \
        kubeconfig/control-plane-${i}.kubeconfig \
        kubeconfig/kube-proxy.kubeconfig \
        containerd/config/config.toml \
        containerd/unitfile/containerd.service \
        configs/kube-proxy/kube-proxy-config.yaml \
        configs/kubelet/control-plane-${i}/kubelet-config.yaml \
        unitfiles/kube-proxy/kube-proxy.service \
        unitfiles/kubelet/control-plane-${i}/kubelet.service \
        install4node.sh \
        control-plane-${i}.k8s.home.arpa:
done

for i in `seq 1 5`
do
    scp \
        certs/cert/kubernetes-ca.pem \
        certs/cert/kubernetes-front-proxy-ca.pem \
        certs/cert/node-${i}.pem \
        certs/cert/node-${i}-key.pem \
        kubeconfig/node-${i}.kubeconfig \
        kubeconfig/kube-proxy.kubeconfig \
        containerd/config/config.toml \
        containerd/unitfile/containerd.service \
        configs/kube-proxy/kube-proxy-config.yaml \
        configs/kubelet/node-${i}/kubelet-config.yaml \
        unitfiles/kube-proxy/kube-proxy.service \
        unitfiles/kubelet/node-${i}/kubelet.service \
        install4node.sh \
        node-${i}.k8s.home.arpa:
done

exit 0
