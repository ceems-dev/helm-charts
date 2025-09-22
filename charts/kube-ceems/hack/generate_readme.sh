#!/bin/bash

# This script generates README file using helm-docs

# Helm docs version
HELM_DOCS_VERSION="1.14.2"

# Generate a temporary directory for helm-docs binary
TMPDIR=$(mktemp -d /tmp/ceems_helm_charts.XXXXXX)

# Get script directory
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Move to root of chart folder
cd "${SCRIPT_DIR}/../" || exit

# Get helm-docs binary
wget -O "${TMPDIR}/helm-docs_${HELM_DOCS_VERSION}_Linux_x86_64.tar.gz" "https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS_VERSION}/helm-docs_${HELM_DOCS_VERSION}_Linux_x86_64.tar.gz"
tar -xvf "${TMPDIR}/helm-docs_${HELM_DOCS_VERSION}_Linux_x86_64.tar.gz" -C "${TMPDIR}"
chmod +x "${TMPDIR}/helm-docs"

# Generate README file from template
"${TMPDIR}/helm-docs" --sort-values-order=file --template-files=.helm-docs/README.gotmpl

# Clean up TMPDIR on exit
finish() {
	rm -rf "${TMPDIR}"
}

trap finish EXIT
