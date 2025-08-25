#!/bin/bash

MASTER_IP="$1"

echo "[INFO] Waiting for node-token from controller..."
while [ ! -f /vagrant_shared/node-token ]; do
  echo "[INFO] node-token not found yet, sleeping 2s..."
  sleep 
