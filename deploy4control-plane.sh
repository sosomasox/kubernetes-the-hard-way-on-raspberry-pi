#!/bin/bash -x

for i in `seq 1 3`
do 
    scp install4control-plane.sh control-plane-${i}.k8s.home.arpa:
    ssh control-plane-${i}.k8s.home.arpa "./install4control-plane.sh"
    ssh control-plane-${i}.k8s.home.arpa "sudo cp etcd-ca.pem /var/lib/kubernetes/etcd-ca.pem"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv etcd-*.pem /etc/etcd/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv *.pem *.kubeconfig /var/lib/kubernetes/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv encryption-config.yaml /etc/kubernetes/config/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-scheduler-control-plane-${i}.yaml /etc/kubernetes/config/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv *.service /etc/systemd/system/"
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl enable etcd kube-apiserver kube-controller-manager kube-scheduler"
done

seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "sudo systemctl start etcd kube-apiserver kube-controller-manager kube-scheduler"

exit 0
