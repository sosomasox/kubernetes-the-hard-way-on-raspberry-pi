#!/bin/bash -x

DEPLOY_CONTROL-PLANE ()
{
seq 1 3 | xargs -I {} -P 3 scp install4node.sh control-plane-{}.k8s.home.arpa:
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "./install4node.sh"
seq 1 3 | xargs -I {} -P 3 ssh control-plane-{}.k8s.home.arpa "rm ./install4node.sh"

for i in `seq 1 3`
do
ssh control-plane-${i}.k8s.home.arpa "sudo mv control-plane-${i}.kubeconfig control-plane-*.pem kubernetes-ca.pem /etc/kubelet/pki/"
ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-proxy.kubeconfig /etc/kube-proxy/pki/"
ssh control-plane-${i}.k8s.home.arpa "sudo mv config.toml /etc/containerd/"
ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-proxy-config.yaml /etc/kube-proxy/config/"
ssh control-plane-${i}.k8s.home.arpa "sudo mv kubelet-config.yaml /etc/kubelet/config/"
ssh control-plane-${i}.k8s.home.arpa "sudo mv *.service /etc/systemd/system/"
ssh control-plane-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
ssh control-plane-${i}.k8s.home.arpa "sudo systemctl enable containerd kubelet kube-proxy"
done

for i in `seq 1 3`
do
ssh control-plane-${i}.k8s.home.arpa "sudo systemctl start containerd kubelet kube-proxy"
done
}


DEPLOY_NODE ()
{
seq 1 8 | xargs -I {} -P 8 scp install4node.sh node-{}.k8s.home.arpa:
seq 1 8 | xargs -I {} -P 8 ssh node-{}.k8s.home.arpa "./install4node.sh"
seq 1 8 | xargs -I {} -P 8 ssh node-{}.k8s.home.arpa "rm ./install4node.sh"

for i in `seq 1 8`
do
ssh node-${i}.k8s.home.arpa "sudo mv node-${i}.kubeconfig node-*.pem kubernetes-ca.pem /etc/kubelet/pki/"
ssh node-${i}.k8s.home.arpa "sudo mv kube-proxy.kubeconfig /etc/kube-proxy/pki/"
ssh node-${i}.k8s.home.arpa "sudo mv config.toml /etc/containerd/"
ssh node-${i}.k8s.home.arpa "sudo mv kube-proxy-config.yaml /etc/kube-proxy/config/"
ssh node-${i}.k8s.home.arpa "sudo mv kubelet-config.yaml /etc/kubelet/config/"
ssh node-${i}.k8s.home.arpa "sudo mv *.service /etc/systemd/system/"
ssh node-${i}.k8s.home.arpa "sudo systemctl daemon-reload"
ssh node-${i}.k8s.home.arpa "sudo systemctl enable containerd kubelet kube-proxy"
done

for i in `seq 1 8`
do
ssh node-${i}.k8s.home.arpa "sudo systemctl start containerd kubelet kube-proxy"
done
}


if [ "$1" = "control-plane" ]; then
    ./scp4node.sh $1
    DEPLOY_CONTROL-PLANE
else
    ./scp4node.sh
    DEPLOY_NODE
fi

exit 0
