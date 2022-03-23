#!/bin/bash -x 

scp \
  certs/cacert/kubernetes-ca.pem \
  certs/cacert/etcd-ca.pem \
  certs/cert/prometheus-etcd-client-key.pem \
  certs/cert/prometheus-etcd-client.pem \
  certs/cert/prometheus-kube-apiserver-client-key.pem \
  certs/cert/prometheus-kube-apiserver-client.pem \
  certs/cert/prometheus-kube-controller-manager-client-key.pem \
  certs/cert/prometheus-kube-controller-manager-client.pem \
  certs/cert/prometheus-kube-scheduler-client-key.pem \
  certs/cert/prometheus-kube-scheduler-client.pem \
  certs/cert/prometheus-kubelet-client-key.pem \
  certs/cert/prometheus-kubelet-client.pem \
  config.home.arpa:/tmp

ssh config.home.arpa \
    "sudo mv /tmp/prometheus-*.pem \
             /tmp/kubernetes-ca.pem \
             /tmp/etcd-ca.pem \
             /etc/prometheus/pki/"
ssh config.home.arpa \
    "sudo chown prometheus:prometheus /etc/prometheus/pki/*"


exit 0
