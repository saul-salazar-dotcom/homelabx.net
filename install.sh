#!/usr/bin/env sh

# exit on error
set -o errexit

# Helper function to generate random strings
generate_random_string() {
  local length=${1:-32}
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -base64 "$length" | tr -d '\n'
  elif command -v python3 >/dev/null 2>&1; then
    python3 -c "import secrets; print(secrets.token_urlsafe(64))"
  else
    # Fallback: use /dev/urandom if available
    head -c "$length" /dev/urandom | base64 | tr -d '\n'
  fi
}

# Function to create .env file if it doesn't exist
create_env_file() {
  local dir="$1"
  local env_file="$dir/.env"
  
  if [ ! -f "$env_file" ]; then
    echo "📝 Creating $env_file..."
    # File will be created by the specific service setup
  fi
}

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

# Generate .env files for each service with sensitive variables

# Design (Penpot)
if [ ! -f ~/homelabx/design/.env ]; then
  cat > ~/homelabx/design/.env << EOF
# Penpot Environment Variables
POSTGRES_USER=penpot
POSTGRES_PASSWORD=$(generate_random_string 32)
POSTGRES_DB=penpot
PENPOT_SECRET_KEY=$(generate_random_string 64)
PENPOT_DATABASE_USERNAME=penpot
PENPOT_DATABASE_PASSWORD=$(generate_random_string 32)
PENPOT_OIDC_CLIENT_SECRET=$(generate_random_string 32)
EOF
  echo "✅ Created ~/homelabx/design/.env"
fi

# Plan (Vikunja)
if [ ! -f ~/homelabx/plan/.env ]; then
  cat > ~/homelabx/plan/.env << EOF
# Vikunja Database Configuration
MYSQL_ROOT_PASSWORD=$(generate_random_string 32)
VIKUNJA_DATABASE_USER=vikunja
VIKUNJA_DATABASE_PASSWORD=$(generate_random_string 32)
VIKUNJA_DATABASE_NAME=vikunja
VIKUNJA_SERVICE_JWTSECRET=$(generate_random_string 64)
EOF
  echo "✅ Created ~/homelabx/plan/.env"
fi

# Schedule (Rallly)
if [ ! -f ~/homelabx/schedule/.env ]; then
  cat > ~/homelabx/schedule/.env << EOF
# Database Configuration for Rallly
DB_POSTGRES_PASSWORD=$(generate_random_string 32)
EOF
  echo "✅ Created ~/homelabx/schedule/.env"
fi

# Schedule config.env (Rallly application config)
if [ ! -f ~/homelabx/schedule/config.env ]; then
  cat > ~/homelabx/schedule/config.env << EOF
# REQUIRED CONFIG

# A postgres database connection string.
DATABASE_URL=postgres://postgres:\${DB_POSTGRES_PASSWORD}@db:5432/db

# A random 32-character secret key used to encrypt user sessions
SECRET_PASSWORD=$(generate_random_string 32)

# The base url where this instance is accessible, including the scheme.
NEXT_PUBLIC_BASE_URL=https://schedule.homelab.com

# Comma separated list of email addresses that are allowed to register and login.
ALLOWED_EMAILS="*"

# Mailing
NOREPLY_EMAIL=noreply@homelab.com
SUPPORT_EMAIL=support@homelab.com
SMTP_HOST=mailcatch
SMTP_PORT=1025
SMTP_SECURE=false
SMTP_USER=
SMTP_PWD=

# SSO with OIDC
OIDC_NAME=Authelia
OIDC_CLIENT_ID=schedule
OIDC_CLIENT_SECRET=$(generate_random_string 32)
OIDC_DISCOVERY_URL=https://auth.homelab.com/.well-known/openid-configuration

# Fix for localhost certificate (unable to verify certificate)
NODE_TLS_REJECT_UNAUTHORIZED=0
EOF
  echo "✅ Created ~/homelabx/schedule/config.env"
fi

# Wiki (Outline)
if [ ! -f ~/homelabx/wiki/.env ]; then
  cat > ~/homelabx/wiki/.env << EOF
# Wiki Database Configuration
POSTGRES_USER=postgres
POSTGRES_PASSWORD=$(generate_random_string 32)
EOF
  echo "✅ Created ~/homelabx/wiki/.env"
fi

# Wiki docker.env (Outline application config)
if [ ! -f ~/homelabx/wiki/docker.env ]; then
  # Generate hex-encoded random values for SECRET_KEY and UTILS_SECRET
  SECRET_KEY_HEX=$(openssl rand -hex 32 2>/dev/null || python3 -c "import secrets; print(secrets.token_hex(32))" 2>/dev/null || head -c 32 /dev/urandom | xxd -p)
  UTILS_SECRET_HEX=$(openssl rand -hex 32 2>/dev/null || python3 -c "import secrets; print(secrets.token_hex(32))" 2>/dev/null || head -c 32 /dev/urandom | xxd -p)
  
  cat > ~/homelabx/wiki/docker.env << EOF
# –––––––––––––––– REQUIRED ––––––––––––––––

NODE_ENV=production

# Fix for localhost certificate (unable to verify certificate)
NODE_TLS_REJECT_UNAUTHORIZED=0

# Generate a hex-encoded 32-byte random key.
SECRET_KEY=$SECRET_KEY_HEX

# Generate a unique random key.
UTILS_SECRET=$UTILS_SECRET_HEX

# For production point these at your databases
DATABASE_URL=postgres://postgres:\${POSTGRES_PASSWORD}@postgres:5432/outline
DATABASE_CONNECTION_POOL_MIN=
DATABASE_CONNECTION_POOL_MAX=
PGSSLMODE=disable

# For redis
REDIS_URL=redis://redis:6379

# URL should point to the fully qualified, publicly accessible URL
URL=http://wiki.homelab.com
PORT=3000

# Specify what storage system to use. Possible value is one of "s3" or "local".
FILE_STORAGE=local

# If "local" is configured for FILE_STORAGE
FILE_STORAGE_LOCAL_ROOT_DIR=/var/lib/outline/data

# Maximum allowed size for the uploaded attachment.
FILE_STORAGE_UPLOAD_MAX_SIZE=262144000
EOF
  echo "✅ Created ~/homelabx/wiki/docker.env"
fi

# Whiteboard (Affine)
if [ ! -f ~/homelabx/whiteboard/.env ]; then
  cat > ~/homelabx/whiteboard/.env << EOF
# Affine Database Configuration
AFFINE_DB_USER=affine
AFFINE_DB_PASSWORD=$(generate_random_string 32)
AFFINE_DB_NAME=affine
EOF
  echo "✅ Created ~/homelabx/whiteboard/.env"
fi

cd ~/homelabx/proxy && docker compose up -d

FILE="$HOME/homelabx/proxy/certs/rootCA.pem"

# Check if the file path is correct and the file exists
echo "⏳ Waiting for mkcert to create a root CA at $FILE..."

# Wait until the file is generated
while [ ! -f "$FILE" ]; do
    sleep 5  # Wait for 5 seconds before checking again
done

# Once the file exists, copy it to the destinations
cp "$FILE" ~/homelabx/plan
cp "$FILE" ~/homelabx/design

echo "✅ rootCA.pem file found and copied to 'plan' and 'design'."

cd ~/homelabx && ./start.sh

echo "✅ Installation and environment setup complete!"
