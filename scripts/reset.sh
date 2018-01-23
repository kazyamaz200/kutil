#!/bin/bash

echo "remote: sudo rm -rf /var/lib/rook"
echo "remote: docker stop $(docker ps -a -q ) && docker rm $(docker ps -a -q) && docker volume rm $(docker volume ls -q)"
IFS=,
user=$1
hosts=$2

for host in $hosts
do
  ssh -i ./id_rsa $user@$host 'sudo rm -rf /var/lib/rook'
  ssh -i ./id_rsa $user@$host 'docker stop $(docker ps -a -q ) && docker rm $(docker ps -a -q) && docker volume rm $(docker volume ls -q)'
  echo "$host"
done
echo "done."
