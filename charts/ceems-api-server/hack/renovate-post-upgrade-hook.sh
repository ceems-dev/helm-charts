#!/bin/bash

# This script updates README using helm-docs

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${0}")" &>/dev/null && pwd)

"${SCRIPT_DIR}/generate_readme.sh"
