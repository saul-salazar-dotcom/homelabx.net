#!/usr/bin/env sh

# exit on error
set -o errexit

git clone https://github.com/saul-salazar-dotcom/homelabx.net.git ~/homelabx

cd ~/homelabx/proxy && docker compose up -d

FILE="$HOME/homelabx/proxy/certs/rootCA.pem"

# Check if the file path is correct and the file exists
echo "⏳ Waiting for mkcert to create a root CA at $FILE..."

# Wait until the file is generated
while [ ! -f "$FILE" ]; do
    sleep 5  # Wait for 5 seconds before checking again
done

# Once the file exists, copy it to the destinations
cp "$FILE" plan
cp "$FILE" design

echo "✅ rootCA.pem file found and copied to 'plan' and 'design'."

cd ~/homelabx && ./start.sh
