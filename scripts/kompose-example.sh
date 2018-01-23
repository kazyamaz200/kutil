#!/bin/bash

## get
curl -o guestbook.yaml https://raw.githubusercontent.com/kubernetes/kompose/master/examples/docker-compose.yaml

## customize
sed -i -e "s/LoadBalancer/ClusterIP/" guestbook.yaml

## convert
kompose convert -j -o cluster1/components/guestbook.jsonnet -f guestbook.yaml
ls cluster1/components/guestbook.jsonnet

## cluenup
rm guestbook.yaml

## addon
cat <<EOL | yaml2json | jq . | cat > cluster1/components/guestbook-ing.jsonnet
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: guestbook
  namespace: default
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: guestbook.service.op
    http:
      paths:
      - path: /
        backend:
          serviceName: frontend
          servicePort: 80
EOL
ls cluster1/components/guestbook-ing.jsonnet
