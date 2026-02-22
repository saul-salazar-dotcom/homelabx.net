#!/usr/bin/env bash
# Generate config.env from config.env.example with dynamic values

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config.env"
CONFIG_EXAMPLE="${SCRIPT_DIR}/config.env.example"

# Check if config.env already exists
if [ -f "$CONFIG_FILE" ]; then
    echo "config.env already exists. Skipping generation."
    exit 0
fi

# Get or generate DB_POSTGRES_PASSWORD
if [ -z "$DB_POSTGRES_PASSWORD" ]; then
    echo "Generating DB_POSTGRES_PASSWORD..."
    DB_POSTGRES_PASSWORD=$(openssl rand -base64 32 | tr -d '=' | cut -c1-32)
fi

# Generate SECRET_PASSWORD if not provided
if [ -z "$GENERATED_SECRET_PASSWORD" ]; then
    echo "Generating SECRET_PASSWORD..."
    GENERATED_SECRET_PASSWORD=$(openssl rand -base64 32 | tr -d '=' | cut -c1-32)
fi

# Create config.env from config.env.example by substituting variables
echo "Creating config.env with generated values..."
cat "$CONFIG_EXAMPLE" | \
    sed "s|\${DB_POSTGRES_PASSWORD}|$DB_POSTGRES_PASSWORD|g" | \
    sed "s|\${GENERATED_SECRET_PASSWORD}|$GENERATED_SECRET_PASSWORD|g" \
    > "$CONFIG_FILE"

echo "✓ config.env generated successfully"
echo "  - DATABASE_URL configured"
echo "  - SECRET_PASSWORD generated"
