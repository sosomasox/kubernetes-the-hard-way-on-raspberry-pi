#!/bin/bash -x

ETCD_VERSION=v3.5.4
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GITHUB_URL}

sudo mkdir -p \
    /etc/etcd/pki/ \
    /var/lib/etcd/ \
    /var/log/etcd/

wget -q --https-only --timestamping ${DOWNLOAD_URL}/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-arm64.tar.gz
tar xzvf etcd-${ETCD_VERSION}-linux-arm64.tar.gz
sudo mv etcd-${ETCD_VERSION}-linux-arm64/etcd* /usr/local/bin/
rm -rf etcd-${ETCD_VERSION}-linux-arm64
rm -f etcd-${ETCD_VERSION}-linux-arm64.tar.gz

exit 0
