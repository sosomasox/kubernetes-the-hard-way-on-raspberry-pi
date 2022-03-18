#!/bin/bash -x

KUBERNETES_VERSION=v1.23.1

sudo mkdir -p \
    /etc/cni/net.d/ \
    /etc/containerd/ \
    /etc/kubelet/config/ \
    /etc/kubelet/pki/ \
    /etc/kube-proxy/config/ \
    /etc/kube-proxy/pki/ \
    /opt/cni/bin/ \
    /var/lib/kubelet/

sudo sh -c "cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF"

sudo modprobe overlay
sudo modprobe br_netfilter

# 必要なカーネルパラメータの設定をします。これらの設定値は再起動後も永続化されます。
sudo sh -c "cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
fs.inotify.max_user_watches         = 20480
EOF"

sudo sysctl --system

sudo apt update
sudo apt install -y iptables arptables ebtables
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo update-alternatives --set arptables /usr/sbin/arptables-legacy
sudo update-alternatives --set ebtables /usr/sbin/ebtables-legacy

sudo apt install -y containerd runc

#sudo apt install -y make git gcc build-essential pkgconf libtool libsystemd-dev libprotobuf-c-dev libcap-dev libseccomp-dev libyajl-dev go-md2man libtool autoconf python3 automake
#git clone https://github.com/containers/crun.git
#cd crun/
#./autogen.sh 
#./configure 
#make
#sudo make install
#/usr/local/bin/crun --version
#cd ../
#rm -rf crun

sudo sh -c 'echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/1.23:/1.23.0/xUbuntu_20.04/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:1.23:1.23.0.list'
sudo sh -c 'echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list'
sudo sh -c "curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:1.23:1.23.0/xUbuntu_20.04/Release.key | apt-key add -"
sudo sh -c "curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/Release.key | apt-key add -"
sudo apt update && sudo apt install -y cri-o cri-o-runc
sudo rm -f /etc/cni/net.d/*

wget -q --https-only --timestamping \
  https://github.com/containernetworking/plugins/releases/download/v1.0.1/cni-plugins-linux-arm64-v1.0.1.tgz
sudo tar -xvf cni-plugins-linux-arm64-v1.0.1.tgz -C /opt/cni/bin/
rm cni-plugins-linux-arm64-v1.0.1.tgz

wget -q --https-only --timestamping \
    https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/arm64/kubelet
chmod +x kubelet
sudo mv kubelet /usr/local/bin/

wget -q --https-only --timestamping \
   https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/arm64/kube-proxy
chmod +x kube-proxy
sudo mv kube-proxy /usr/local/bin/

exit 0
