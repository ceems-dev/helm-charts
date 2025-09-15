#!/bin/bash

# This script updates the dashboards by fetching them from CEEMS repository
# and update README using helm-docs

# Git ref of ceems repo
# renovate: git-refs=https://github.com/ceems-dev/ceems branch=main
REF=e902120b98fb41018d9f312471e07d111f4ea22b

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

# Get helm-docs binary and update README based on template
wget https://github.com/norwoodj/helm-docs/releases/download/v1.14.2/helm-docs_1.14.2_Linux_x86_64.tar.gz
tar -xvf helm-docs_1.14.2_Linux_x86_64.tar.gz
chmod +x helm-docs
helm-docs --sort-values-order=file --template-files=.helm-docs/README.gotmpl
