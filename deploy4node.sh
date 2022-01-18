#!/bin/bash -x

./scp4node.sh

seq 1 3 | xargs -I {} -P 3 scp install4node.sh control-plane-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "./install4node.sh"
for i in `seq 1 3`
do
    ssh control-plane-${i}.k8s.home.arpa "mv control-plane-${i}.kubeconfig kubeconfig"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv kubeconfig control-plane-*.pem /var/lib/kubelet/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv *.pem /var/lib/kubernetes/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv config.toml /etc/containerd/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-proxy-config.yaml /etc/kube-proxy/config/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv kubelet-config.yaml /etc/kubelet/config/"
    ssh control-plane-${i}.k8s.home.arpa "sudo mv *.service /etc/systemd/system/"
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl enable containerd kubelet kube-proxy"
done
seq 1 5 | xargs -I {} -P 5 scp install4node.sh node-{}.k8s.home.arpa:
seq 1 5 | xargs -I {} -P 5 ssh node-{}.k8s.home.arpa "./install4node.sh"
for i in `seq 1 5`
do
    ssh node-${i}.k8s.home.arpa "mv node-${i}.kubeconfig kubeconfig"
    ssh node-${i}.k8s.home.arpa "sudo mv kubeconfig node-*.pem /var/lib/kubelet/"
    ssh node-${i}.k8s.home.arpa "sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/"
    ssh node-${i}.k8s.home.arpa "sudo mv *.pem /var/lib/kubernetes/"
    ssh node-${i}.k8s.home.arpa "sudo mv config.toml /etc/containerd/"
    ssh node-${i}.k8s.home.arpa "sudo mv kube-proxy-config.yaml /etc/kube-proxy/config/"
    ssh node-${i}.k8s.home.arpa "sudo mv kubelet-config.yaml /etc/kubelet/config/"
    ssh node-${i}.k8s.home.arpa "sudo mv *.service /etc/systemd/system/"
    ssh node-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
    ssh node-${i}.k8s.home.arpa "sudo systemctl enable containerd kubelet kube-proxy"
done

for i in `seq 1 3`
do
    ssh control-plane-${i}.k8s.home.arpa "sudo systemctl start containerd kubelet kube-proxy"
done
for i in `seq 1 5`
do
    ssh node-${i}.k8s.home.arpa "sudo systemctl start containerd kubelet kube-proxy"
done

exit 0
