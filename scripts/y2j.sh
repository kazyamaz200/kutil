#!/bin/bash

function y2j() {
    cat $1 | \
    sed -e "/^#/d" -e "/^$/d" -e "s/^/  /" | sed -e "/  ---/{n; s/^  /- /}" | sed -e "/---/d" -e "1s/  /- /" -e "1s/^/apiVersion: v1\nkind: List\nitems:\n/" | \
    yaml2json | jq . | \
    cat > $2
    ls $2
}

y2j $1 $2