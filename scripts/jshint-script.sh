#!/usr/bin/env bash
set -uo pipefail
printf 'JSHint report\nRepository: ShenXuanfan/bitcoin-order-app\nCommit: %s\nDate (UTC): %s\n\n' "${GITHUB_SHA:-local}" "$(date -u +%FT%TZ)" > JSHint-report
jshint --exclude="node_modules/,server/node_modules/,dist/,.git/" --reporter=unix . >> JSHint-report 2>&1
status=$?
printf '\nJSHint exit code: %s\n' "$status" >> JSHint-report
cat JSHint-report
case "$status" in
  0) echo 'JSHint completed without findings.' ;;
  2) echo '::warning::JSHint found code issues. Read JSHint-report; this workshop collects findings without blocking publication.' ;;
  *) exit "$status" ;;
esac
