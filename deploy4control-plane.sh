#!/bin/bash -x

./scp4control-plane.sh

seq 1 3 | xargs -I {} -P 3 scp install4control-plane.sh control-plane-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "./install4control-plane.sh"
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "rm ./install4control-plane.sh"

for i in `seq 1 3`
do 
    ssh control-plane-${i}.k8s.home.arpa "sudo mv *.pem *.kubeconfig /etc/kubernetes/pki/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv encryption-config.yaml /etc/kubernetes/config/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-scheduler-control-plane-${i}.yaml /etc/kubernetes/config/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv *.service /etc/systemd/system/"
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl enable kube-apiserver kube-controller-manager kube-scheduler"
done

seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler"

exit 0
