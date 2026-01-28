#!/usr/bin/env sh

# exit on error
set -o errexit

# Check if Docker is NOT installed
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found, installing..."

  OS="$(uname -s)"

  case "$OS" in
    Linux)
      curl -fsSL https://get.docker.com | sh
      ;;
    Darwin)
      echo "macOS detected"
      echo "Install Docker Desktop manually or via Homebrew"
      exit 1
      ;;
    MINGW*|MSYS*|CYGWIN*)
      echo "Windows detected"
      echo "Install Docker Desktop manually: "
      exit 1
      ;;
    *)
      echo "Unsupported OS: $OS"
      exit 1
      ;;
  esac
fi

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
