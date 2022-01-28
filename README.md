# kubernetes-the-hard-way-on-raspberry-pi

### Prerequisites

```
sudo apt update
sudo apt install -y golang-cfssl
```



### etcd

```
etcdctl endpoint status --write-out=table --endpoints=etcd-1.k8s.home.arpa:2379,etcd-2.k8s.home.arpa:2379,etcd-3.k8s.home.arpa:2379 --cacert certs/cacert/etcd-ca.pem --cert certs/cert/etcd-healthcheck-client.pem --key certs/cert/etcd-healthcheck-client-key.pem
```



### metrics

#### etcd

```
curl -sk --cacert certs/cacert/etcd-ca.pem --cert certs/cert/etcd-1.pem --key certs/cert/etcd-1-key.pem https://etcd-1.k8s.home.arpa:2379/metrics
```


#### kube-apiserver

```
curl -sk --cacert certs/cacert/kubernetes-ca.pem --cert certs/cert/admin.pem --key certs/cert/admin-key.pem https://control-plane-1.k8s.home.arpa:6443/metrics
```


#### kube-controller-manager

```
curl -sk --cacert certs/cacert/kubernetes-ca.pem --cert certs/cert/admin.pem --key certs/cert/admin-key.pem https://control-plane-1.k8s.home.arpa:10257/metrics
```


#### kube-scheduler

```
curl -sk --cacert certs/cacert/kubernetes-ca.pem --cert certs/cert/admin.pem --key certs/cert/admin-key.pem https://control-plane-1.k8s.home.arpa:10259/metrics
```


#### kubelet

```
curl -sk --cacert certs/cacert/kubernetes-ca.pem --cert certs/cert/kube-apiserver-kubelet-client.pem --key certs/cert/kube-apiserver-kubelet-client-key.pem https://node-1.k8s.home.arpa:10250/metrics
```
