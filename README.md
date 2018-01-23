# kutil

kutil is the client toolbox for manage kubernetes cluster.

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

***cluster setup***

see [scripts](scripts/README.md)

## Includes

- [kubernetes/kubectl](https://github.com/kubernetes/kubectl)

```
$ docker run kutil/kutil kubectl version
Client Version: version.Info{Major:"1", Minor:"9", GitVersion:"v1.9.1", GitCommit:"3a1c9449a956b6026f075fa3134ff92f7d55f812", GitTreeState:"clean", BuildDate:"2018-01-04T11:52:23Z", GoVersion:"go1.9.2", Compiler:"gc", Platform:"linux/amd64"}
```

- [rancher/rke](https://github.com/rancher/rke)

```
$ docker run kutil/kutil rke --version
rke version v0.0.12-dev
```

- [wercker/stern](https://github.com/wercker/stern)

```
$ docker run kutil/kutil stern --version
stern version 1.6.0
```

- [openfaas/faas-cli](https://github.com/openfaas/faas-cli)

```
$ docker run kutil/kutil faas-cli version
Commit: d1d38e9b2d5600a3485442b75641bf73b566313b
Version: 0.5.1
```

- [ksonnet/ksonnet](https://github.com/ksonnet/ksonnet)

```
$ docker run kutil/kutil ks version
ksonnet version: v0.8.0
jsonnet version: v0.9.5
client-go version: v1.6.8-beta.0+$Format:%h$
```

- [kubernetes/kompose](https://github.com/kubernetes/kompose)

```
$ docker run kutil/kutil kompose version
1.7.0 (767ab4b)
```

- [istio/istio](https://github.com/istio/istio)

```
docker run kutil/kutil istioctl version
Version: 0.4.0
GitRevision: 24089ea97c8d244493c93b499a666ddf4010b547
GitBranch: 6401744b90b43901b2aa4a8bced33c7bd54ffc13
User: root@cc5c34bbd1ee
GolangVersion: go1.9.1
```

- [bronze1man/yaml2json](https://github.com/bronze1man/yaml2json)

```
echo "a: 1" | yaml2json
yaml2json < 1.yml > 2.json
```
