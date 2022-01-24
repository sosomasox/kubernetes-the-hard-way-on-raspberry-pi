#!/bin/bash -x

sudo systemctl stop keepalived.service haproxy.service
sudo apt remove --purge -y keepalived haproxy
sudo rm /etc/keepalived/keepalived.conf
sudo rm /etc/haproxy/haproxy.cfg  
sudo rm /etc/systemd/system/keepalived.service
sudo rm /etc/systemd/system/haproxy.service

exit 0
