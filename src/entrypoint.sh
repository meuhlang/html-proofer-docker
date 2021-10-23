#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

main() {
  if [ "${GITHUB_ACTIONS:-}" != "true" ]; then
    # We are not being run by GitHub Actions.
    exec "$@"
    exit 1
  fi

  set -- "${INPUT_PATH}" \
    --allow-hash-href "${INPUT_ALLOW_HASH_HREF}" \
    --enforce-https "${INPUT_ENFORCE_HTTPS}"

  if [ -n "${INPUT_URL_IGNORE}" ]; then
    set -- "$@" --url-ignore "${INPUT_URL_IGNORE}"
  fi

  htmlproofer "$@"
}

main "$@"
