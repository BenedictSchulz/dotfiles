#!/bin/bash

# Set these env vars in your shell config or .env file:
#   DEPLOY_HOST, DEPLOY_PATH, SITE_DIR, CONTENT_SOURCE
: "${DEPLOY_HOST:?Set DEPLOY_HOST in your environment}"
: "${DEPLOY_PATH:?Set DEPLOY_PATH in your environment}"
: "${SITE_DIR:?Set SITE_DIR in your environment}"
: "${CONTENT_SOURCE:?Set CONTENT_SOURCE in your environment}"

cd "$SITE_DIR"

rsync -av --delete "$CONTENT_SOURCE" src/content/posts/

# Clear Astro caches to prevent stale content
rm -rf .astro node_modules/.astro dist

npm run build
rsync -avz --delete dist/ "${DEPLOY_HOST}:${DEPLOY_PATH}"
echo "Clean deploy complete!"
