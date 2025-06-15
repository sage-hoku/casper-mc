#!/bin/bash

git remote update
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Updates found, pulling..."
    docker compose stop mc-lsv
    git pull
    docker compose start mc-lsv
else
    echo "No changes."
fi
