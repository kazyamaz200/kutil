# Scripts for [kutil/kutil](https://hub.docker.com/r/kutil/kutil/)

## Getting Started

***a) work on local container***
```
mkdir work && cd work
docker run -it -v $PWD:/work kutil/kutil:edge
```

***b) work on remote container***
```
rancher exec -it cluster1/kutil bash
```

***clone this***
```
git clone https://github.com/kyamazawa/kutil-scripts.git scripts
```

## Setup(on `kutil` container)

### Start Kubernetes Cluster

```
ssh-keygen -t rsa -C "${ACCOUT_USER_NAME}" -b 4096 #=> for ssh
cat /work/id_rsa.pub #=> add to authorized_keys
rke config #=> interactive setup
rke up #=> start kubernetes cluster
```

### After start

```
scripts/ksonnet.sh
scripts/repos.sh
```

### Prepre components(jsonnet)

```
scripts/ingress-nginx.sh
scripts/weave-scope.sh
scripts/rook.sh
scripts/kompose-example.sh
scripts/faas.sh
scripts/istio.sh
```

### Before deploy

```
scripts/reset-rook-data.sh SSH_USERNAME HOST1,HOST2,HOST3
```

### Component List

```
cd /work/cluster1 && ks component list
```



## Deploy

### 1. Deploy Ingress controller for Nginx

```
ks apply default \
-c ing-ng-configmap \
-c ing-ng-default-backend \
-c ing-ng-namespace \
-c ing-ng-rbac \
-c ing-ng-service-nodeport \
-c ing-ng-tcp-services-configmap \
-c ing-ng-udp-services-configmap \
-c ing-ng-with-rbac
```

```
kubectl -n ingress-nginx get all
```

### 2. Deploy weave scope

```
ks apply default \
-c weave-scope \
-c weave-scope-ing
```

```
kubectl -n weave get all
kubectl -n weave get ing
```

http://weave.service.op

### 3. Deploy guestbook converted from docker-compose

```
ks apply default \
-c guestbook \
-c guestbook-ing
```

```
kubectl -n default get all
kubectl -n default get ing
```

http://guestbook.service.op

### 4. Deploy Rook fundamental

```
ks apply default \
-c rook-operator
```

```
kubectl -n rook-system get all
```

### 5. Deploy Rook cluster

```
ks apply default \
-c rook-cluster
```

```
kubectl -n rook get all
```

### 6. Deploy Rook Block Storage & Wordpress

```
ks apply default \
-c rook-storageclass \
-c rook-ex-mysql \
-c rook-ex-wordpress \
-c rook-ex-wordpress-ing
```

```
kubectl get pvc
kubectl -n default get all
kubectl -n default get ing
```

http://wordpress.service.op

### 7. Deploy Rook Shared File System & Rook tools

```
ks apply default \
-c rook-filesystem \
-c rook-tools
```

```
kubectl -n rook get pod -l app=rook-ceph-mds
kubectl -n rook exec -it rook-tools bash
ceph status
rookctl status
ceph df
rados df
```

### 8. Deploy Kube Registry for test

```
ks apply default \
-c rook-ex-kube-registry
```

```
# Mount the same filesystem that the kube-registry is using
mkdir /tmp/registry
rookctl filesystem mount --name myfs --path /tmp/registry

# If you have pushed images to the registry you will see a directory called docker
ls /tmp/registry

# Cleanup the filesystem mount
rookctl filesystem unmount --path /tmp/registry
rmdir /tmp/registry
```

### 9. Deploy Rook Object Storage

```
ks apply default \
-c rook-object \
-c rook-ex-rgw-ing
```

```
kubectl -n rook get pod -l app=rook-ceph-rgw
kubectl -n rook exec -it rook-tools bash
rookctl object user create my-store rook-user "A rook rgw User"
rookctl object connection my-store rook-user --format env-var
kubectl -n rook get all
kubectl -n rook get ing
```

http://rgw.service.op

### 10. Deploy OpenFaaS

```
ks apply default \
-c faas-alertmanager \
-c faas-alertmanager_config \
-c faas-faasnetesd \
-c faas-gateway \
-c faas-ing \
-c faas-namespaces \
-c faas-nats \
-c faas-prometheus \
-c faas-prometheus_config \
-c faas-queueworker \
-c faas-rbac
```

```
kubectl -n openfaas get all
kubectl -n openfaas get ing
```

http://gateway.service.op
http://prometheus.service.op

```
faas-cli ls --gateway http://gateway.service.op
```

### 11. Deploy Istio

```
ks apply default \
-c istio-crd
```

```
kubectl get crd
```

```
ks apply default \
-c istio-auth-nocrd
```

```
kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

```
istioctl kube-inject -f <(ks show default -c istio-bookinfo-raw) | \
sed -e "/^#/d" -e "/^$/d" -e "s/^/  /" | sed -e "/  ---/{n; s/^  /- /}" | sed -e "/---/d" -e "1s/  /- /" -e "1s/^/apiVersion: v1\nkind: List\nitems:\n/" | \
yaml2json | jq . | \
cat > components/istio-bookinfo.jsonnet

ks apply default -c istio-bookinfo
```

```
kubectl get pod
kubectl get svc
kubectl get ing
```

## Teardown

***components***
```
cd /work/cluster1
ks delete default
```

***kubernetes***
```
cd /work
rke remove
```

