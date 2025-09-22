#!/bin/bash

set -euo pipefail

{
	SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

	cd "${SCRIPT_DIR}/../hack"

	./generate_readme.sh
	if ! git diff "$GITHUB_SHA" --color=always --exit-code; then
		echo "Changes inside README is not supported!"
		echo "Please go into the ./hack/ directory and run ./generate_readme.sh"
		exit 1
	fi

	./sync_grafana_dashboards.sh
	if ! git diff "$GITHUB_SHA" --color=always --exit-code; then
		echo "Changes inside dashboards are not supported!"
		echo "Please go into the ./hack/ directory and run ./sync_grafana_dashboards.sh"
		exit 1
	fi
} 2>&1
