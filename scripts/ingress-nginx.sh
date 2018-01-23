#!/bin/bash

## convert
$(dirname $0)/y2j.sh ingress-nginx/deploy/namespace.yaml cluster1/components/ing-ng-namespace.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/default-backend.yaml cluster1/components/ing-ng-default-backend.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/configmap.yaml cluster1/components/ing-ng-configmap.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/tcp-services-configmap.yaml cluster1/components/ing-ng-tcp-services-configmap.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/udp-services-configmap.yaml cluster1/components/ing-ng-udp-services-configmap.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/rbac.yaml cluster1/components/ing-ng-rbac.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/with-rbac.yaml cluster1/components/ing-ng-with-rbac.jsonnet
$(dirname $0)/y2j.sh ingress-nginx/deploy/provider/baremetal/service-nodeport.yaml cluster1/components/ing-ng-service-nodeport.jsonnet
