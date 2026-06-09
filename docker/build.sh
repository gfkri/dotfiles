#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ -z "${1:-}" ]]; then
    echo "Usage: build.sh <variant> [--tag <tag>] [docker build args...]"
    echo ""
    echo "Available variants:"
    for d in "${SCRIPT_DIR}"/*/; do
        [[ -f "${d}Dockerfile" ]] && echo "  $(basename "$d")"
    done
    exit 1
fi

VARIANT="$1"
shift

TAG="gfkri/dotfiles:${VARIANT}"
EXTRA_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --tag)
            TAG="$2"
            shift 2
            ;;
        --bust-cache)
            EXTRA_ARGS+=("--build-arg" "CACHEBUST=$(date +%s)")
            shift
            ;;
        *)
            EXTRA_ARGS+=("$1")
            shift
            ;;
    esac
done

if [[ ! -d "${SCRIPT_DIR}/${VARIANT}" ]]; then
    echo "Error: variant '${VARIANT}' not found in ${SCRIPT_DIR}"
    echo ""
    echo "Available variants:"
    for d in "${SCRIPT_DIR}"/*/; do
        [[ -f "${d}Dockerfile" ]] && echo "  $(basename "$d")"
    done
    exit 1
fi

docker build \
    --build-arg USERNAME="${USERNAME:-appuser}" \
    --build-arg USER_UID="${USER_UID:-1001}" \
    --build-arg USER_GID="${USER_GID:-1001}" \
    "${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}" \
    --tag "$TAG" \
    --file "${SCRIPT_DIR}/${VARIANT}/Dockerfile" \
    "${SCRIPT_DIR}/${VARIANT}"

echo "Built: $TAG"

docker image prune -f

echo ""
echo "Run with:"
echo "  docker run --rm -it -e LOCAL_UID=\$(id -u) -e LOCAL_GID=\$(id -g) $TAG"
