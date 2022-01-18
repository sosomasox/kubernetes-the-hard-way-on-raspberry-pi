#!/bin/bash

for i in `seq 1 3`
do
    scp \
        certs/cert/etcd-ca.pem \
        certs/cert/etcd-${i}.pem \
        certs/cert/etcd-${i}-key.pem \
        certs/cert/etcd-peer-${i}.pem \
        certs/cert/etcd-peer-${i}-key.pem \
        certs/cert/kubernetes-ca.pem \
        certs/cert/kubernetes-ca-key.pem \
        certs/cert/kube-apiserver-control-plane-${i}.pem \
        certs/cert/kube-apiserver-control-plane-${i}-key.pem \
        certs/cert/kube-apiserver-etcd-client.pem \
        certs/cert/kube-apiserver-etcd-client-key.pem \
        certs/cert/kube-apiserver-kubelet-client.pem \
        certs/cert/kube-apiserver-kubelet-client-key.pem \
        certs/cert/kube-scheduler-control-plane-${i}.pem \
        certs/cert/kube-scheduler-control-plane-${i}-key.pem \
        certs/cert/service-account.pem \
        certs/cert/service-account-key.pem \
        certs/cert/kubernetes-front-proxy-ca.pem \
        certs/cert/front-proxy-client.pem \
        certs/cert/front-proxy-client-key.pem \
        kubeconfig/kube-controller-manager-control-plane-${i}.kubeconfig \
        kubeconfig/kube-scheduler-control-plane-${i}.kubeconfig \
        configs/kube-apiserver/encryption-config.yaml \
        configs/kube-scheduler/kube-scheduler-control-plane-${i}.yaml \
        unitfiles/etcd/control-plane-${i}/etcd.service \
        unitfiles/kube-apiserver/control-plane-${i}/kube-apiserver.service \
        unitfiles/kube-controller-manager/-control-plane-${i}/kube-controller-manager.service \
        unitfiles/kube-scheduler/-control-plane-${i}/kube-scheduler.service \
        install4control-plane.sh \
        control-plane-${i}.k8s.home.arpa:
done

exit 0
