#!/bin/bash

CERT=cert_`date +%Y%m%d`
KUBECONFIG=kubeconfig_`date +%Y%m%d`

ls certs/${CERT}/ >/dev/null 2>&1
if [ $? != 0 ]; then
  echo "Please run in the same directory as ${CERT}" 
  exit
fi

mkdir ${KUBECONFIG}

echo "---> Generate kube-controller-manager kubeconfig"
for i in `seq 1 3`
do
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cacert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=${KUBECONFIG}/kube-controller-manager-control-plane-${i}.kubeconfig
kubectl config set-credentials default-controller-manager \
  --client-certificate=./certs/${CERT}/kube-controller-manager-control-plane-${i}.pem \
  --client-key=./certs/${CERT}/kube-controller-manager-control-plane-${i}-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBECONFIG}/kube-controller-manager-control-plane-${i}.kubeconfig
kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=default-controller-manager \
  --kubeconfig=${KUBECONFIG}/kube-controller-manager-control-plane-${i}.kubeconfig
kubectl config use-context kubernetes-the-hard-way --kubeconfig=${KUBECONFIG}/kube-controller-manager-control-plane-${i}.kubeconfig
done

echo "---> Generate kube-scheduler kubeconfig"
for i in `seq 1 3`
do
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cacert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=${KUBECONFIG}/kube-scheduler-control-plane-${i}.kubeconfig
kubectl config set-credentials default-scheduler \
  --client-certificate=./certs/${CERT}/kube-scheduler-control-plane-${i}.pem \
  --client-key=./certs/${CERT}/kube-scheduler-control-plane-${i}-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBECONFIG}/kube-scheduler-control-plane-${i}.kubeconfig
kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=default-scheduler \
  --kubeconfig=${KUBECONFIG}/kube-scheduler-control-plane-${i}.kubeconfig
kubectl config use-context kubernetes-the-hard-way --kubeconfig=${KUBECONFIG}/kube-scheduler-control-plane-${i}.kubeconfig
done

echo "---> Generate admin user kubeconfig"
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cacert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=${KUBECONFIG}/admin.kubeconfig
kubectl config set-credentials default-admin \
  --client-certificate=./certs/${CERT}/admin.pem \
  --client-key=./certs/${CERT}/admin-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBECONFIG}/admin.kubeconfig
kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=default-admin \
  --kubeconfig=${KUBECONFIG}/admin.kubeconfig
kubectl config use-context kubernetes-the-hard-way --kubeconfig=${KUBECONFIG}/admin.kubeconfig

echo "---> Generate kubelet kubeconfig"
for i in `seq 1 3`
do
kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=./certs/cacert/kubernetes-ca.pem \
    --embed-certs=true \
    --server=https://192.168.114.10:64430 \
    --kubeconfig=${KUBECONFIG}/control-plane-${i}.kubeconfig
kubectl config set-credentials system:node:control-plane-${i}.k8s.home.arpa \
    --client-certificate=./certs/${CERT}/control-plane-${i}.pem \
    --client-key=./certs/${CERT}/control-plane-${i}-key.pem \
    --embed-certs=true \
    --kubeconfig=${KUBECONFIG}/control-plane-${i}.kubeconfig 
kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:control-plane-${i}.k8s.home.arpa \
    --kubeconfig=${KUBECONFIG}/control-plane-${i}.kubeconfig
kubectl config use-context default --kubeconfig=${KUBECONFIG}/control-plane-${i}.kubeconfig
done
for i in `seq 1 5`
do
kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=./certs/cacert/kubernetes-ca.pem \
    --embed-certs=true \
    --server=https://192.168.114.10:64430 \
    --kubeconfig=${KUBECONFIG}/node-${i}.kubeconfig
kubectl config set-credentials system:node:node-${i}.k8s.home.arpa \
    --client-certificate=./certs/${CERT}/node-${i}.pem \
    --client-key=./certs/${CERT}/node-${i}-key.pem \
    --embed-certs=true \
    --kubeconfig=${KUBECONFIG}/node-${i}.kubeconfig
kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:node-${i}.k8s.home.arpa \
    --kubeconfig=${KUBECONFIG}/node-${i}.kubeconfig
kubectl config use-context default --kubeconfig=${KUBECONFIG}/node-${i}.kubeconfig
done

echo "---> Generate kube-proxy kubeconfig"
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cacert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=${KUBECONFIG}/kube-proxy.kubeconfig
kubectl config set-credentials system:kube-proxy \
  --client-certificate=./certs/${CERT}/kube-proxy.pem \
  --client-key=./certs/${CERT}/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBECONFIG}/kube-proxy.kubeconfig
kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=system:kube-proxy \
  --kubeconfig=${KUBECONFIG}/kube-proxy.kubeconfig
kubectl config use-context default --kubeconfig=${KUBECONFIG}/kube-proxy.kubeconfig

echo "---> Complete to generate kubeconfig"

exit 0
