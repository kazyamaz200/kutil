#!/bin/bash

git clone https://github.com/kubernetes/ingress-nginx.git
git clone https://github.com/rook/rook.git
git clone https://github.com/openfaas/faas-netes.git
curl -L https://git.io/getLatestIstio | sh -
cp istio*/bin/* /usr/local/bin/.