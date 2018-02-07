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
$ docker run kutil/kutil:release rke --version
rke version v0.1.1-rc2
```

- [wercker/stern](https://github.com/wercker/stern)

```
$ docker run kutil/kutil:release stern --version
stern version 1.6.0
```

- [openfaas/faas-cli](https://github.com/openfaas/faas-cli)

```
$ docker run kutil/kutil:release faas-cli version
Commit: 2a790b4a6702c533137801279a9288b4691977c6
Version: 0.6.1
```

- [ksonnet/ksonnet](https://github.com/ksonnet/ksonnet)

release

```
$ docker run kutil/kutil:release ks version
ksonnet version: v0.8.0
jsonnet version: v0.9.5
client-go version: v1.6.8-beta.0+$Format:%h$
```

edge

```
ksonnet version: dev-2018-01-23T04:30:10+0000
jsonnet version: v0.9.5
client-go version: 1.6+
```

- [kubernetes/kompose](https://github.com/kubernetes/kompose)

```
$ docker run kutil/kutil:edge kompose version
1.8.0 (0c0c027)
```

- [istio/istio](https://github.com/istio/istio)

```
$ docker run kutil/kutil:release istioctl version
Version: 0.5.0
GitRevision: c9debceacb63a14a9ae24df433e2ec3ce1f16fc7
User: root@211b132eb7f1
Hub: docker.io/istio
GolangVersion: go1.9
BuildStatus: Clean
```

- [bronze1man/yaml2json](https://github.com/bronze1man/yaml2json)

```
echo "a: 1" | yaml2json
yaml2json < 1.yml > 2.json
```
