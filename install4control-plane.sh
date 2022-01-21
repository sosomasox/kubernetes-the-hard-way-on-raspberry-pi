#!/bin/bash -x

KUBERNETES_VERSION=v1.23.1

sudo mkdir -p \
    /etc/kubernetes/config/ \
    /var/lib/kubernetes/

wget -q --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kube-apiserver
sudo chmod +x kube-apiserver
sudo mv kube-apiserver /usr/local/bin

wget -q --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kube-controller-manager
sudo chmod +x kube-controller-manager
sudo mv kube-controller-manager /usr/local/bin

wget -q --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kube-scheduler
sudo chmod +x kube-scheduler
sudo mv kube-scheduler /usr/local/bin

wget -q --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin

exit 0
