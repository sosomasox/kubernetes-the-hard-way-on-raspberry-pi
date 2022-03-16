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
    containerd/config/config.toml \
    containerd/unitfile/containerd.service \
    configs/kube-proxy/kube-proxy-config.yaml \
    configs/kubelet/control-plane-${i}/kubelet-config.yaml \
    unitfiles/kube-proxy/kube-proxy.service \
    unitfiles/kubelet/control-plane-${i}/kubelet.service \
    control-plane-${i}.k8s.home.arpa:
done
}


SCP_NODE ()
{
for i in `seq 1 4`
do
scp \
    certs/cacert/kubernetes-ca.pem \
    certs/cert/node-${i}.pem \
    certs/cert/node-${i}-key.pem \
    kubeconfig/node-${i}.kubeconfig \
    kubeconfig/kube-proxy.kubeconfig \
    containerd/config/config.toml \
    containerd/unitfile/containerd.service \
    configs/kube-proxy/kube-proxy-config.yaml \
    configs/kubelet/node-${i}/kubelet-config.yaml \
    unitfiles/kube-proxy/kube-proxy.service \
    unitfiles/kubelet/node-${i}/kubelet.service \
    node-${i}.k8s.home.arpa:
done
}


if [ "$1" = "control-plane" ]; then
    SCP_CONTROL-PLANE
else
    SCP_NODE
fi

exit 0
