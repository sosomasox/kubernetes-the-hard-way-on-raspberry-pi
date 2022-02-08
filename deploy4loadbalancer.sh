#!/bin/bash -x

./scp4loadbalancer.sh

seq 1 3 | xargs -I {} -P 3 scp install4loadbalancer.sh loadbalancer-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh loadbalancer-{}.k8s.home.arpa "./install4loadbalancer.sh"
seq 1 3 | xargs -I {} -P 3 ssh loadbalancer-{}.k8s.home.arpa "rm ./install4loadbalancer.sh"

for i in `seq 1 3`
do
    ssh loadbalancer-${i}.k8s.home.arpa "sudo mv keepalived.conf /etc/keepalived/"
    ssh loadbalancer-${i}.k8s.home.arpa "sudo mv haproxy.cfg /etc/haproxy/"
    ssh loadbalancer-${i}.k8s.home.arpa "sudo mv keepalived.service /etc/systemd/system/"
    ssh loadbalancer-${i}.k8s.home.arpa "sudo mv haproxy.service /etc/systemd/system/"
    ssh loadbalancer-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
    ssh loadbalancer-${i}.k8s.home.arpa "sudo systemctl enable keepalived haproxy"
done

seq 1 3 | xargs -I {} -P 3 ssh loadbalancer-{}.k8s.home.arpa "sudo systemctl restart keepalived haproxy"

exit 0
