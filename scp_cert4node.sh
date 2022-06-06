#!/bin/bash -x

SCP_CONTROL-PLANE ()
{
for i in `seq 1 3`
do
scp \
    certs/cacert/kubernetes-ca.pem \
    certs/cert/control-plane-${i}.pem \
    certs/cert/control-plane-${i}-key.pem \
    kubeconfig/control-plane-${i}.kubeconfig \
    kubeconfig/kube-proxy.kubeconfig \
    control-plane-${i}.k8s.home.arpa:
ssh control-plane-${i}.k8s.home.arpa "sudo mv control-plane-${i}.kubeconfig control-plane-*.pem kubernetes-ca.pem /etc/kubelet/pki/"
ssh control-plane-${i}.k8s.home.arpa "sudo mv kube-proxy.kubeconfig /etc/kube-proxy/pki/"
done
}

SCP_NODE ()
{
for i in `seq 1 7`
do
scp \
    certs/cacert/kubernetes-ca.pem \
    certs/cert/node-${i}.pem \
    certs/cert/node-${i}-key.pem \
    kubeconfig/node-${i}.kubeconfig \
    kubeconfig/kube-proxy.kubeconfig \
    node-${i}.k8s.home.arpa:
ssh node-${i}.k8s.home.arpa "sudo mv node-${i}.kubeconfig node-*.pem kubernetes-ca.pem /etc/kubelet/pki/"
ssh node-${i}.k8s.home.arpa "sudo mv kube-proxy.kubeconfig /etc/kube-proxy/pki/"

done
}


if [ "$1" = "control-plane" ]; then
    SCP_CONTROL-PLANE
else
    SCP_NODE
fi

exit 0
