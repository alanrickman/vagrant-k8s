#!/bin/bash

# Kill existing screen session
screen -X -S kubectl_proxy quit

# Start new screen session and start kubectl proxy inside it
screen -dmS kubectl_proxy bash -c "kubectl proxy"

echo "Go to http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"
