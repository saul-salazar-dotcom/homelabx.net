#!/usr/bin/env sh

path=$(pwd)
for name in authelia proxy smtp tv downloads torrents notes changelog wiki whiteboard design read schedule plan 
do
    echo "🚀 Starting service ${name}"
    cd "$path/$name"
    if [ -z "$RECREATE" ]; then
        docker compose up -d
    else
        docker compose up -d --force-recreate
    fi
done

echo "✅ All Services started"
