#!/bin/bash -x

pushd certs

echo "---> Generate certificate for kubelet"
for i in `seq 1 3`
do
cfssl gencert \
    -ca=./cert/kubernetes-ca.pem \
    -ca-key=./cert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubelet \
    ./config/control-plane-${i}-csr.json | cfssljson -bare ./cert/control-plane-${i}
done
for i in `seq 1 5`
do
cfssl gencert \
    -ca=./cert/kubernetes-ca.pem \
    -ca-key=./cert/kubernetes-ca-key.pem \
    -config=./config/kubernetes-ca-config.json \
    -profile=kubelet \
    ./config/node-${i}-csr.json | cfssljson -bare ./cert/node-${i}
done

popd

echo "---> Complete to generate certificate for kubelet"

exit 0
