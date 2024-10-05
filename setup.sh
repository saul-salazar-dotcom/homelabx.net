#!/usr/bin/env sh

# Setup DNS
HOSTS_FILE="/etc/hosts"
echo "# homelab" | sudo tee --append $HOSTS_FILE

# media
echo "127.0.1.1  tv.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  torrents.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  downloads.homelab.com" | sudo tee --append $HOSTS_FILE

# documentation
echo "127.0.1.1  wiki.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  notes.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  changelog.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  whiteboard.homelab.com" | sudo tee --append $HOSTS_FILE

# tools
echo "127.0.1.1  design.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  read.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  schedule.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  plan.homelab.com" | sudo tee --append $HOSTS_FILE

# infrastructure
echo "127.0.1.1  traefik.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  auth.homelab.com" | sudo tee --append $HOSTS_FILE
echo "127.0.1.1  smtp.homelab.com" | sudo tee --append $HOSTS_FILE

