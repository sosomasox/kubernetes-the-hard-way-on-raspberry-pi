#!/bin/bash

ls certs/cert >/dev/null 2>&1
if [ $? != 0 ]; then
  echo "Please run in the same directory as cert" 
  exit
fi

echo "---> Generate kube-controller-manager kubeconfig"
for i in `seq 1 3`
do
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=kubeconfig/kube-controller-manager-control-plane-${i}.kubeconfig
kubectl config set-credentials default-controller-manager \
  --client-certificate=./certs/cert/kube-controller-manager-control-plane-${i}.pem \
  --client-key=./certs/cert/kube-controller-manager-control-plane-${i}-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/kube-controller-manager-control-plane-${i}.kubeconfig
kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=default-controller-manager \
  --kubeconfig=kubeconfig/kube-controller-manager-control-plane-${i}.kubeconfig
kubectl config use-context kubernetes-the-hard-way --kubeconfig=kubeconfig/kube-controller-manager-control-plane-${i}.kubeconfig
done

echo "---> Generate kube-scheduler kubeconfig"
for i in `seq 1 3`
do
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=kubeconfig/kube-scheduler-control-plane-${i}.kubeconfig
kubectl config set-credentials default-scheduler \
  --client-certificate=./certs/cert/kube-scheduler-control-plane-${i}.pem \
  --client-key=./certs/cert/kube-scheduler-control-plane-${i}-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/kube-scheduler-control-plane-${i}.kubeconfig
kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=default-scheduler \
  --kubeconfig=kubeconfig/kube-scheduler-control-plane-${i}.kubeconfig
kubectl config use-context kubernetes-the-hard-way --kubeconfig=kubeconfig/kube-scheduler-control-plane-${i}.kubeconfig
done

echo "---> Generate admin user kubeconfig"
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=kubeconfig/admin.kubeconfig
kubectl config set-credentials default-admin \
  --client-certificate=./certs/cert/admin.pem \
  --client-key=./certs/cert/admin-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/admin.kubeconfig
kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=default-admin \
  --kubeconfig=kubeconfig/admin.kubeconfig
kubectl config use-context kubernetes-the-hard-way --kubeconfig=kubeconfig/admin.kubeconfig

echo "---> Generate kubelet kubeconfig"
for i in `seq 1 3`
do
kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=./certs/cert/kubernetes-ca.pem \
    --embed-certs=true \
    --server=https://192.168.114.10:64430 \
    --kubeconfig=kubeconfig/control-plane-${i}.kubeconfig
kubectl config set-credentials system:node:control-plane-${i}.k8s.home.arpa \
    --client-certificate=./certs/cert/control-plane-${i}.pem \
    --client-key=./certs/cert/control-plane-${i}-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfig/control-plane-${i}.kubeconfig 
kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:control-plane-${i}.k8s.home.arpa \
    --kubeconfig=kubeconfig/control-plane-${i}.kubeconfig
kubectl config use-context default --kubeconfig=kubeconfig/control-plane-${i}.kubeconfig
done
for i in `seq 1 5`
do
kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=./certs/cert/kubernetes-ca.pem \
    --embed-certs=true \
    --server=https://192.168.114.10:64430 \
    --kubeconfig=kubeconfig/node-${i}.kubeconfig
kubectl config set-credentials system:node:node-${i}.k8s.home.arpa \
    --client-certificate=./certs/cert/node-${i}.pem \
    --client-key=./certs/cert/node-${i}-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfig/node-${i}.kubeconfig
kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:node-${i}.k8s.home.arpa \
    --kubeconfig=kubeconfig/node-${i}.kubeconfig
kubectl config use-context default --kubeconfig=kubeconfig/node-${i}.kubeconfig
done

echo "---> Generate kube-proxy kubeconfig"
kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=./certs/cert/kubernetes-ca.pem \
  --embed-certs=true \
  --server=https://192.168.114.10:64430 \
  --kubeconfig=kubeconfig/kube-proxy.kubeconfig
kubectl config set-credentials system:kube-proxy \
  --client-certificate=./certs/cert/kube-proxy.pem \
  --client-key=./certs/cert/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kubeconfig/kube-proxy.kubeconfig
kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=system:kube-proxy \
  --kubeconfig=kubeconfig/kube-proxy.kubeconfig
kubectl config use-context default --kubeconfig=kubeconfig/kube-proxy.kubeconfig

echo "---> Complete to generate kubeconfig"

exit 0
