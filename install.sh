#!/usr/bin/env sh

# exit on error
set -o errexit

git clone https://github.com/saul-salazar-dotcom/homelabx.net.git ~/homelabx

cd ~/homelabx/proxy && docker compose up -d

FILE="$HOME/homelabx/proxy/certs/rootCA.pem"
echo "⏳ Waiting for mkcert to create a root CA..."
while true; do
    if [ -f "$FILE" ]; then
        cp "$FILE" plan
        cp "$FILE" design
        break
    fi
    sleep 5  # Wait for 5 seconds before checking again
done

cd ~/homelabx && ./start.sh
