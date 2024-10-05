#!/usr/bin/env sh

git clone https://github.com/saul-salazar-dotcom/homelabx.net.git ~/homelabx

cd ~/homelabx/proxy && docker compose up -d
echo "⏳ Wait while mkcert creates a root CA"
sleep 5
ln -s proxy/rootCA.pem plan/rootCA.pem
ln -s proxy/rootCA.pem design/rootCA.pem

cd ~/homelabx
./start.sh
