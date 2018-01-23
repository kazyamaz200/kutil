#!/bin/bash

## convert
$(dirname $0)/y2j.sh faas-netes/namespaces.yml cluster1/components/faas-namespaces.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/alertmanager.yml cluster1/components/faas-alertmanager.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/alertmanager_config.yml cluster1/components/faas-alertmanager_config.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/faasnetesd.yml cluster1/components/faas-faasnetesd.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/gateway.yml cluster1/components/faas-gateway.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/nats.yml cluster1/components/faas-nats.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/prometheus.yml cluster1/components/faas-prometheus.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/prometheus_config.yml cluster1/components/faas-prometheus_config.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/queueworker.yml cluster1/components/faas-queueworker.jsonnet
$(dirname $0)/y2j.sh faas-netes/yaml/rbac.yml cluster1/components/faas-rbac.jsonnet

## customize
sed -i -e "s/NodePort/ClusterIP/" -e "/nodePort/d" cluster1/components/faas-gateway.jsonnet 
sed -i -e "s/NodePort/ClusterIP/" -e "/nodePort/d" cluster1/components/faas-prometheus.jsonnet

## addon
cat <<EOL | yaml2json | jq . | cat > cluster1/components/faas-ing.jsonnet
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: openfaas
  namespace: openfaas
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: gateway.service.op
    http:
      paths:
      - path: /
        backend:
          serviceName: gateway
          servicePort: 8080
  - host: prometheus.service.op
    http:
      paths:
      - path: /
        backend:
          serviceName: prometheus
          servicePort: 9090
EOL
ls cluster1/components/faas-ing.jsonnet
