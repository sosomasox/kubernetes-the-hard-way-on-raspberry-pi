#!/bin/bash -x

pushd certs

ls cert/ >/dev/null 2>&1
if [ $? != 0 ]; then
  echo "Please run in the same directory as cert"
  exit
fi

echo "---> Generate certificate for prometheus-etcd-client"
cfssl gencert \
    -ca=./cacert/etcd-ca.pem \
    -ca-key=./cacert/etcd-ca-key.pem \
    -config=./config/etcd-ca-config.json \
    -profile=etcd \
    ./config/prometheus-etcd-client-csr.json | cfssljson -bare ./cert/prometheus-etcd-client

echo "---> Generate certificate for prometheus-kube-apiserver-client"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/prometheus-kube-apiserver-client-csr.json | cfssljson -bare ./cert/prometheus-kube-apiserver-client

echo "---> Generate certificate for prometheus-kube-controller-manager-client"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/prometheus-kube-controller-manager-client-csr.json | cfssljson -bare ./cert/prometheus-kube-controller-manager-client

echo "---> Generate certificate for prometheus-kube-scheduler-client"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/prometheus-kube-scheduler-client-csr.json | cfssljson -bare ./cert/prometheus-kube-scheduler-client

echo "---> Generate certificate for prometheus-kubelet-client"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/prometheus-kubelet-client-csr.json | cfssljson -bare ./cert/prometheus-kubelet-client

exit 0
