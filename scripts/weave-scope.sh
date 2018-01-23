#!/bin/bash

## convert
curl -X GET "https://cloud.weave.works/k8s/v1.7/scope.yaml" | yaml2json | jq . | cat > cluster1/components/weave-scope.jsonnet
ls cluster1/components/weave-scope.jsonnet

## addon
cat <<EOL | yaml2json | jq . | cat > cluster1/components/weave-scope-ing.jsonnet           
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: weave
  namespace: weave
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: weave.service.op
    http:
      paths:
      - path: /
        backend:
          serviceName: weave-scope-app
          servicePort: 80
EOL
ls cluster1/components/weave-scope-ing.jsonnet
