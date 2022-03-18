#!/bin/bash -x

pushd certs

mkdir cacert/ cert/
if [ $? != 0 ]; then
  exit 1
fi

echo "---> Generate etcd ca certificate"
cfssl gencert \
    -initca ./config/etcd-ca-csr.json | cfssljson -bare ./cacert/etcd-ca

echo "---> Generate kubernetes ca certificate"
cfssl gencert \
    -initca ./config/kubernetes-ca-csr.json | cfssljson -bare ./cacert/kubernetes-ca

echo "---> Generate kubernetes front proxy ca certificate"
cfssl gencert \
    -initca ./config/kubernetes-front-proxy-ca-csr.json | cfssljson -bare ./cacert/kubernetes-front-proxy-ca

echo "---> Generate certificate etcd"
for i in `seq 1 3`
do 
cfssl gencert \
    -ca=./cacert/etcd-ca.pem \
    -ca-key=./cacert/etcd-ca-key.pem \
    -config=./config/etcd-ca-config.json \
    -profile=etcd \
    ./config/etcd-csr.json | cfssljson -bare ./cert/etcd-${i}
done

echo "---> Generate certificate etcd-peer"
for i in `seq 1 3`
do
cfssl gencert \
    -ca=./cacert/etcd-ca.pem \
    -ca-key=./cacert/etcd-ca-key.pem \
    -config=./config/etcd-ca-config.json \
    -profile=etcd \
    ./config/etcd-peer-csr.json | cfssljson -bare ./cert/etcd-peer-${i}
done

echo "---> Generate certificate etcd-healthcheck-client"
cfssl gencert \
    -ca=./cacert/etcd-ca.pem \
    -ca-key=./cacert/etcd-ca-key.pem \
    -config=./config/etcd-ca-config.json \
    -profile=etcd \
    ./config/etcd-healthcheck-client-csr.json | cfssljson -bare ./cert/etcd-healthcheck-client

echo "---> Generate certificate kube-apiserver-etcd-client"
cfssl gencert \
    -ca=./cacert/etcd-ca.pem \
    -ca-key=./cacert/etcd-ca-key.pem \
    -config=./config/etcd-ca-config.json \
    -profile=etcd \
    ./config/kube-apiserver-etcd-client-csr.json | cfssljson -bare ./cert/kube-apiserver-etcd-client

echo "---> Generate certificate for kubernetes admin user"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/admin-csr.json | cfssljson -bare ./cert/admin

echo "---> Generate certificate for kube-apiserver"
for i in `seq 1 3`
do
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/kube-apiserver-csr.json | cfssljson -bare ./cert/kube-apiserver-control-plane-${i}
done

echo "---> Generate certificate for kube-apiserver-kubelet-client"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/kube-apiserver-kubelet-client-csr.json | cfssljson -bare ./cert/kube-apiserver-kubelet-client

echo "---> Generate certificate for kube-controller-manager"
for i in `seq 1 3`
do
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/kube-controller-manager-csr.json | cfssljson -bare ./cert/kube-controller-manager-control-plane-${i}
done

echo "---> Generate certificate for kube-scheduler"
for i in `seq 1 3`
do
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubernetes \
    ./config/kube-scheduler-csr.json | cfssljson -bare ./cert/kube-scheduler-control-plane-${i}
done

echo "---> Generate certificate for front-proxy-client"
cfssl gencert \
    -ca=./cacert/kubernetes-front-proxy-ca.pem \
    -ca-key=./cacert/kubernetes-front-proxy-ca-key.pem \
    -config=./config/kubernetes-front-proxy-ca-config.json \
    -profile=kubernetes-front-proxy \
    ./config/front-proxy-client-csr.json | cfssljson -bare ./cert/front-proxy-client

echo "---> Generate certificate for generating token of ServiceAccount"
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=service-account \
    ./config/service-account-csr.json | cfssljson -bare ./cert/service-account

echo "---> Generate certificate for kubelet"
for i in `seq 1 3`
do
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubelet \
    ./config/control-plane-${i}-csr.json | cfssljson -bare ./cert/control-plane-${i}
done
for i in `seq 1 8`
do
cfssl gencert \
    -ca=./cacert/kubernetes-ca.pem \
    -ca-key=./cacert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubelet \
    ./config/node-${i}-csr.json | cfssljson -bare ./cert/node-${i}
done

echo "---> Generate certificate for kube-proxy"
cfssl gencert \
  -ca=./cacert/kubernetes-ca.pem \
  -ca-key=./cacert/kubernetes-ca-key.pem \
  -config=./config/kubernetes-ca-config.json \
  -profile=kube-proxy \
  ./config/kube-proxy-csr.json | cfssljson -bare ./cert/kube-proxy

popd

echo "---> Complete to generate certificate"

exit 0
