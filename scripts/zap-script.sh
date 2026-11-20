#!/usr/bin/env bash
set -euo pipefail
mkdir -p zap-reports
# The container's zap user needs to write into this dedicated report directory.
chmod 777 zap-reports
docker pull ghcr.io/zaproxy/zaproxy:stable
# Passive baseline only. -I retains warnings without failing on warnings.
# Actual scanner execution errors still fail the workflow.
docker run --rm -v "$PWD/zap-reports:/zap/wrk:rw" \
  ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
  -t "https://shenxuanfan.github.io/bitcoin-order-app/" \
  -m 1 -T 10 -I -l PASS \
  -r zap_baseline_report.html -J zap_baseline_report.json \
  2>&1 | tee zap-reports/zap-console.log
