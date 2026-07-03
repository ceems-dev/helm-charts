#!/bin/bash

# This script updates the dashboards by fetching them from CEEMS repository

# Git ref of ceems repo
# renovate: git-refs=https://github.com/ceems-dev/ceems branch=main
REF=8e2142aa781a235f2449f1bbbf79b697d560479b

# Get script directory
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Get dashboards directory
DASHBOARDS_DIR="$(dirname "${SCRIPT_DIR}")/files/dashboards"

# Synchronize dashboards
for DASH in "admin/cluster-status.json" "k8s/k8s-pod-summary.json" "k8s/k8s-single-pod-metrics.json" "k8s/k8s-single-pod-metrics-with-pyroscope.json" "openstack/os-single-vm-metrics.json" "openstack/os-vm-summary.json" "slurm/slurm-job-summary.json" "slurm/slurm-single-job-metrics.json" "slurm/slurm-single-job-metrics-with-pyroscope.json" "lsf/lsf-job-summary.json" "lsf/lsf-single-job-metrics.json" "lsf/lsf-single-job-metrics-with-pyroscope.json"; do
	FOLDER="$(cut -d '/' -f 1 <<<"$DASH")"
	mkdir -p "${DASHBOARDS_DIR}/${FOLDER}"
	curl -sf -o "${DASHBOARDS_DIR}/${DASH}" "https://raw.githubusercontent.com/ceems-dev/ceems/${REF}/thirdparty/grafana/dashboards/${DASH}"
	echo "Dashboard ${DASH} synchronized to ${DASHBOARDS_DIR}"
done
