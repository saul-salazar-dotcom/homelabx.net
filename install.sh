#!/usr/bin/env sh

git clone https://github.com/saul-salazar-dotcom/homelabx.net.git ~/homelabx

cd ~/homelabx/proxy && docker compose up -d

FILE="$HOME/homelabx/proxy/rootCA.pem"
echo "⏳ Waiting for mkcert to create a root CA..."
while true; do
    if [[ -f "$FILE" ]]; then
        ln -s proxy/rootCA.pem plan/rootCA.pem
        ln -s proxy/rootCA.pem design/rootCA.pem
        break
    fi
    sleep 5  # Wait for 5 seconds before checking again
done

cd ~/homelabx && ./start.sh
