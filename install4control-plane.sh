#!/bin/bash

ETCD_VERSION=v3.5.1
KUBERNETES_VERSION=v1.23.1
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GITHUB_URL}

sudo mkdir -p \
    /etc/etcd/ \
    /var/lib/etcd/ \
    /var/log/etcd/ \
    /etc/kubernetes/config/ \
    /var/lib/kubernetes/

wget -q --show-progress --https-only --timestamping ${DOWNLOAD_URL}/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-arm64.tar.gz
tar xzvf etcd-${ETCD_VERSION}-linux-arm64.tar.gz
sudo mv etcd-${ETCD_VERSION}-linux-arm64/etcd* /usr/local/bin/
rm -rf etcd-${ETCD_VERSION}-linux-arm64
rm -f etcd-${ETCD_VERSION}-linux-arm64.tar.gz

wget -q --show-progress --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kube-apiserver
sudo chmod +x kube-apiserver
sudo mv kube-apiserver /usr/local/bin

wget -q --show-progress --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kube-controller-manager
sudo chmod +x kube-controller-manager
sudo mv kube-controller-manager /usr/local/bin

wget -q --show-progress --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kube-scheduler
sudo chmod +x kube-scheduler
sudo mv kube-scheduler /usr/local/bin

wget -q --show-progress --https-only --timestamping https://dl.k8s.io/${KUBERNETES_VERSION}/bin/linux/arm64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin

exit 0
