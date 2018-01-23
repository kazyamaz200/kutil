#!/bin/bash

echo "remote: rm -rf /var/lib/rook"
IFS=,
user=$1
hosts=$2

for host in $hosts
do
  ssh -i ./id_rsa $user@$host sudo rm -rf /var/lib/rook
  echo "$host"
done
echo "done."
