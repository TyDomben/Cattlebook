#!/usr/bin/env bash
set -euo pipefail

# Fail loudly if any required env var is missing
: "${SB_URL:?SB_URL env var is required}"
: "${SB_KEY:?SB_KEY env var is required}"
: "${APP_PIN:?APP_PIN env var is required}"

mkdir -p dist

# Copy static assets unchanged
cp manifest.json sw.js dist/

# Inject secrets into the HTML — placeholders become real values only at build time
sed \
  -e "s|__SB_URL__|${SB_URL}|g" \
  -e "s|__SB_KEY__|${SB_KEY}|g" \
  -e "s|__APP_PIN__|${APP_PIN}|g" \
  index.html > dist/index.html

echo "Build complete — secrets injected, dist/ ready."
