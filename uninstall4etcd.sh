#!/bin/bash -x

sudo systemctl stop etcd.service

sudo systemctl disable etcd.service

sudo rm -rf \
    /etc/etcd/ \
    /var/lib/etcd/ \
    /var/log/etcd/ \
    /etc/systemd/system/etcd.service

exit 0
