#!/bin/bash

for i in `seq 1 3`
do
scp \
    certs/cacert/etcd-ca.pem \
    certs/cacert/kubernetes-ca.pem \
    certs/cacert/kubernetes-ca-key.pem \
    certs/cacert/kubernetes-front-proxy-ca.pem \
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
    certs/cert/front-proxy-client.pem \
    certs/cert/front-proxy-client-key.pem \
    kubeconfig/kube-controller-manager-control-plane-${i}.kubeconfig \
    kubeconfig/kube-scheduler-control-plane-${i}.kubeconfig \
    control-plane-${i}.k8s.home.arpa:
ssh control-plane-${i}.k8s.home.arpa "sudo mv *.pem *.kubeconfig /etc/kubernetes/pki/"
done

exit 0
