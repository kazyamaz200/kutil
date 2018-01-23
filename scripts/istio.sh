#!/bin/bash

## istio-*/install/kubernetes
$(dirname $0)/y2j.sh istio-*/install/kubernetes/istio-auth.yaml cluster1/components/istio-auth.jsonnet
# $(dirname $0)/y2j.sh istio-*/install/kubernetes/istio.yaml cluster1/components/istio.jsonnet
# $(dirname $0)/y2j.sh istio-*/install/kubernetes/istio-initializer.yaml cluster1/components/istio-initializer.jsonnet
# $(dirname $0)/y2j.sh istio-*/install/kubernetes/istio-ca-plugin-certs.yaml cluster1/components/istio-ca-plugin-certs.jsonnet
# $(dirname $0)/y2j.sh istio-*/install/kubernetes/istio-one-namespace-auth.yaml cluster1/components/istio-one-namespace-auth.jsonnet
# $(dirname $0)/y2j.sh istio-*/install/kubernetes/istio-one-namespace.yaml cluster1/components/istio-one-namespace.jsonnet
# $(dirname $0)/y2j.sh istio-*/install/kubernetes/mesh-expansion.yaml cluster1/components/mesh-expansion.jsonnet

## istio-*/install/kubernetes/addons
$(dirname $0)/y2j.sh istio-*/install/kubernetes/addons/grafana.yaml cluster1/components/grafana.jsonnet
$(dirname $0)/y2j.sh istio-*/install/kubernetes/addons/prometheus.yaml cluster1/components/prometheus.jsonnet
$(dirname $0)/y2j.sh istio-*/install/kubernetes/addons/servicegraph.yaml cluster1/components/servicegraph.jsonnet
$(dirname $0)/y2j.sh istio-*/install/kubernetes/addons/zipkin-to-stackdriver.yaml cluster1/components/zipkin-to-stackdriver.jsonnet
$(dirname $0)/y2j.sh istio-*/install/kubernetes/addons/zipkin.yaml cluster1/components/zipkin.jsonnet

## istio-*/samples/bookinfo/kube
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-add-serviceaccount.yaml cluster1/components/bookinfo-add-serviceaccount.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-db.yaml cluster1/components/bookinfo-db.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-mysql.yaml cluster1/components/bookinfo-mysql.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-ratings-v2-mysql-vm.yaml cluster1/components/bookinfo-ratings-v2-mysql-vm.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-ratings-v2-mysql.yaml cluster1/components/bookinfo-ratings-v2-mysql.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-ratings-v2.yaml cluster1/components/bookinfo-ratings-v2.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-ratings.yaml cluster1/components/bookinfo-ratings.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo-reviews-v2.yaml cluster1/components/bookinfo-reviews-v2.jsonnet
$(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/bookinfo.yaml cluster1/components/istio-bookinfo-raw.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/destination-policy-reviews.yaml cluster1/components/destination-policy-reviews.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/mixer-rule-additional-telemetry.yaml cluster1/components/mixer-rule-additional-telemetry.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/mixer-rule-deny-label.yaml cluster1/components/mixer-rule-deny-label.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/mixer-rule-deny-serviceaccount.yaml cluster1/components/mixer-rule-deny-serviceaccount.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/mixer-rule-ratings-denial.yaml cluster1/components/mixer-rule-ratings-denial.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/mixer-rule-ratings-ratelimit.yaml cluster1/components/mixer-rule-ratings-ratelimit.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-all-v1.yaml cluster1/components/route-rule-all-v1.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-ratings-db.yaml cluster1/components/route-rule-ratings-db.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-ratings-mysql-vm.yaml cluster1/components/route-rule-ratings-mysql-vm.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-ratings-mysql.yaml cluster1/components/route-rule-ratings-mysql.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-ratings-test-delay.yaml cluster1/components/route-rule-ratings-test-delay.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-reviews-50-v3.yaml cluster1/components/route-rule-reviews-50-v3.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-reviews-test-v2.yaml cluster1/components/route-rule-reviews-test-v2.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-reviews-v2-v3.yaml cluster1/components/route-rule-reviews-v2-v3.jsonnet
# $(dirname $0)/y2j.sh istio-*/samples/bookinfo/kube/route-rule-reviews-v3.yaml cluster1/components/route-rule-reviews-v3.jsonnet

## customize
sed -i -e "s/LoadBalancer/NodePort/" cluster1/components/istio-auth.jsonnet
# sed -i -e "s/LoadBalancer/NodePort/" cluster1/components/istio.jsonnet

# extract crd                                                                                                                        
cat cluster1/components/istio-auth.jsonnet | jq -c '{apiVersion,kind,items: .items | map(select(.kind | contains("CustomResourceDefinition"))) }' | jq . | cat > cluster1/components/istio-crd.jsonnet
ls cluster1/components/istio-crd.jsonnet                                                                                             
                                                                                                                               
# exclude crd
cat cluster1/components/istio-auth.jsonnet | jq -c '{apiVersion,kind,items: .items | map(select(.kind | (contains("CustomResourceDefinition") | not ))) }' | jq . | cat > cluster1/components/istio-auth-nocrd.jsonnet
ls cluster1/components/istio-auth-nocrd.jsonnet
             
# cat cluster1/components/istio.jsonnet | jq -c '{apiVersion,kind,items: .items | map(select(.kind | (contains("CustomResourceDefinition") | not ))) }' | jq . | cat > cluster1/components/istio-nocrd.jsonnet
# ls cluster1/components/istio-nocrd.jsonnet