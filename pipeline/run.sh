#!/usr/bin/env bash
set -euo pipefail
mkdir -p outputs

if [[ ! -f "data/sites.csv" ]]; then
  echo "ERROR: data/sites.csv not found. Copy data/sites_template.csv to data/sites.csv and fill rows." >&2
  exit 1
fi

# 1) Collector → cleaned.csv
gemini -y \
  --include-directories agents,data \
  -i $' @agents/collector.prompt.md\n\nInputs:\n@data/sites.csv\n@data/user_prefs.yaml\n\nReturn ONLY CSV.' \
  > outputs/cleaned.csv

# 2) Analyzer → scores.csv
gemini -y \
  --include-directories agents,data,outputs \
  -i $' @agents/analyzer.prompt.md\n\nInputs:\n@outputs/cleaned.csv\n@data/user_prefs.yaml\n\nReturn ONLY CSV. First line must be a single commented line with thresholds & weights.' \
  > outputs/scores.csv

# 3) Responder → recommendations.md (+ shortlist.csv)
gemini -y \
  --include-directories agents,outputs \
  -i $' @agents/responder.prompt.md\n\nInputs:\n@outputs/scores.csv\n\nReturn ONLY the markdown document.' \
  > outputs/recommendations.md

# Fallback shortlist if model omitted it (top-2 eligible by descending TotalScore)
if [[ ! -f outputs/shortlist.csv ]]; then
  awk 'NR==1 && $0 !~ /^#/ {hdr=$0} NR>1 && $0 !~ /^#/ {print $0}' FS=',' outputs/scores.csv \
  | awk -F',' '$13=="yes"{print $0}' \
  | sort -t',' -k18,18gr \
  | head -n 2 \
  | awk -F',' 'BEGIN{OFS=","} {print $1,$4,$3,$2,$18,$19}' \
  | (echo "site_id,venue_name,city,country,TotalScore,rank" && cat) > outputs/shortlist.csv || true
fi

echo "Artifacts ready in ./outputs"
