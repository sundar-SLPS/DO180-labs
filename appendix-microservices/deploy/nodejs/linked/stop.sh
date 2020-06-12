#!/bin/bash

# if there was a problem with run.sh delete data dir so the database cab be re-initialized:
# rm -rf data

echo -n "• Deleting containers: "
sudo podman stop todo_frontend &>/dev/null
sudo podman stop todoapi &>/dev/null
sudo podman stop mysql &>/dev/null
sudo podman rm todo_frontend &>/dev/null
sudo podman rm todoapi &>/dev/null
sudo podman rm mysql &>/dev/null
echo "OK"

echo -n "• Deleting network: "
sudo podman network rm do180-app-bridge &>/dev/null
echo "OK"
