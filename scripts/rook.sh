#!/bin/bash

## convert
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/rook-operator.yaml cluster1/components/rook-operator.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/rook-cluster.yaml cluster1/components/rook-cluster.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/rook-storageclass.yaml cluster1/components/rook-storageclass.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/mysql.yaml cluster1/components/rook-ex-mysql.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/wordpress.yaml cluster1/components/rook-ex-wordpress.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/rook-filesystem.yaml cluster1/components/rook-filesystem.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/rook-tools.yaml cluster1/components/rook-tools.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/kube-registry.yaml cluster1/components/rook-ex-kube-registry.jsonnet
$(dirname $0)/y2j.sh rook/cluster/examples/kubernetes/rook-object.yaml cluster1/components/rook-object.jsonnet

## customize
sed -i -e "s/20Gi/1Gi/" cluster1/components/rook-ex-mysql.jsonnet
sed -i -e "s/20Gi/1Gi/" -e "s/LoadBalancer/ClusterIP/" cluster1/components/rook-ex-wordpress.jsonnet

## addon
cat <<EOL | yaml2json | jq . | cat > cluster1/components/rook-ex-wordpress-ing.jsonnet
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: wordpress
  namespace: default
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: wordpress.service.op
    http:
      paths:
      - path: /
        backend:
          serviceName: wordpress
          servicePort: 80
EOL
ls cluster1/components/rook-ex-wordpress-ing.jsonnet

cat <<EOL | yaml2json | jq . | cat > cluster1/components/rook-ex-rgw-ing.jsonnet
apiVersion: extensions/v1beta1
kind: Ingress                                                                                        
metadata:                                                                         
  name: rgw
  namespace: rook
  annotations:                                     
    kubernetes.io/ingress.class: "nginx"        
spec:
  rules:                                                                                 
  - host: rgw.service.op                                            
    http:    
      paths:
      - path: /                                
        backend:                                                 
          serviceName: rook-ceph-rgw-my-store           
          servicePort: 80
EOL


