#!/bin/sh
set -euo pipefail

trap stop INT

scale() {
    echo "Scaling down..."
    kubectl scale deployment coredns --replicas=$1 -n kube-system
    echo "Waiting..."
    kubectl rollout status -nkube-system deployment/coredns
}

stop() {
    echo "Exiting..."
    scale 1
}

scale 1
echo "Scaled down... press enter to start test"
read w

while true; do
    scale 20
    scale 1
done
