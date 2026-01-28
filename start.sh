#!/bin/sh

# Loop through all entries in the current directory
for dir in *; do
    # Skip if it's not a directory
    [ -d "$dir" ] || continue

    # Skip specific directory names
    case "$dir" in
        ai|custom_theme)
              continue
        ;;
    esac

    echo "🚀 Starting service ${dir}"
    cd "$path/$dir"
    if [ -z "$RECREATE" ]; then
        docker compose up -d
    else
        docker compose up -d --force-recreate
    fi
done

echo "✅ All Services started"
