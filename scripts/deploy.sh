#!/bin/bash

# Set these env vars in your shell config or .env file:
#   DEPLOY_HOST, DEPLOY_PATH, SITE_DIR, CONTENT_SOURCE
: "${DEPLOY_HOST:?Set DEPLOY_HOST in your environment}"
: "${DEPLOY_PATH:?Set DEPLOY_PATH in your environment}"
: "${SITE_DIR:?Set SITE_DIR in your environment}"
: "${CONTENT_SOURCE:?Set CONTENT_SOURCE in your environment}"

cd "$SITE_DIR"

# Sync and capture if any files were deleted
RSYNC_OUTPUT=$(rsync -av --delete --itemize-changes "$CONTENT_SOURCE" src/content/posts/)

# Only clear cache if something was deleted
if echo "$RSYNC_OUTPUT" | grep -q "^\*deleting"; then
    rm -rf dist/ .astro/ node_modules/.astro/
fi

npm run build
rsync -avz --delete dist/ "${DEPLOY_HOST}:${DEPLOY_PATH}"
echo "Deployed!"
