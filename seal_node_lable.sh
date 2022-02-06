#!/bin/bash -x

kubectl label node control-plane-1.k8s.home.arpa node-role.kubernetes.io/etcd=''
kubectl label node control-plane-2.k8s.home.arpa node-role.kubernetes.io/etcd=''
kubectl label node control-plane-3.k8s.home.arpa node-role.kubernetes.io/etcd=''

kubectl label node control-plane-1.k8s.home.arpa node-role.kubernetes.io/control-plane=''
kubectl label node control-plane-2.k8s.home.arpa node-role.kubernetes.io/control-plane=''
kubectl label node control-plane-3.k8s.home.arpa node-role.kubernetes.io/control-plane=''

kubectl label node control-plane-1.k8s.home.arpa node-role.kubernetes.io/node=''
kubectl label node control-plane-2.k8s.home.arpa node-role.kubernetes.io/node=''
kubectl label node control-plane-3.k8s.home.arpa node-role.kubernetes.io/node=''

kubectl label node node-1.k8s.home.arpa node-role.kubernetes.io/node=''
kubectl label node node-2.k8s.home.arpa node-role.kubernetes.io/node=''
kubectl label node node-3.k8s.home.arpa node-role.kubernetes.io/node=''
kubectl label node node-4.k8s.home.arpa node-role.kubernetes.io/node=''
kubectl label node node-5.k8s.home.arpa node-role.kubernetes.io/node=''

exit 0
