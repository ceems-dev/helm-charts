#!/bin/bash

# This script updates the dashboards by fetching them from CEEMS repository

# Git ref of ceems repo
# renovate: git-refs=https://github.com/ceems-dev/ceems branch=main
REF=55ff78bfc44925a6417b9dd48dcf6207a0a6cafb

# Get script directory
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Get dashboards directory
DASHBOARDS_DIR="$(dirname "${SCRIPT_DIR}")/files/dashboards"

# Synchronize dashboards
for DASH in "admin/cluster-status.json" "k8s/k8s-pod-summary.json" "k8s/k8s-single-pod-metrics.json" "openstack/os-single-vm-metrics.json" "openstack/os-vm-summary.json" "slurm/slurm-job-summary.json" "slurm/slurm-single-job-metrics.json"; do
	FOLDER="$(cut -d '/' -f 1 <<<"$DASH")"
	mkdir -p "${DASHBOARDS_DIR}/${FOLDER}"
	curl -sf -o "${DASHBOARDS_DIR}/${DASH}" "https://raw.githubusercontent.com/ceems-dev/ceems/${REF}/thirdparty/grafana/dashboards/${DASH}"
	echo "Dashboard ${DASH} synchronized to ${DASHBOARDS_DIR}"
done
