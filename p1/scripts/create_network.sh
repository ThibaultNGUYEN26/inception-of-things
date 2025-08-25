#!/usr/bin/env bash
set -euo pipefail

# Always talk to the system libvirt daemon
conn="qemu:///system"
virshs="sudo virsh -c $conn"

# Define the network if missing
if $virshs net-info iot-net &>/dev/null; then
  echo "[iot-net] already defined."
else
  echo "[iot-net] defining network…"
  tmp=$(mktemp)
  cat >"$tmp" <<'EOF'
<network>
  <name>iot-net</name>
  <forward mode='nat'/>
  <ip address='192.168.56.1' netmask='255.255.255.0'/>
</network>
EOF
  $virshs net-define "$tmp"
  rm -f "$tmp"
fi

# Ensure autostart and start if not active
$virshs net-autostart iot-net || true
if ! $virshs net-info iot-net | grep -q "Active:\s*yes"; then
  $virshs net-start iot-net || true
fi

$virshs net-info iot-net

