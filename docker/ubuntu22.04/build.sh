#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-gfkri/dotfiles:ubuntu22.04}"

docker build \
    --tag "$TAG" \
    --file "$(dirname "$0")/Dockerfile" \
    .

echo "Built: $TAG"

docker image prune -f
