#!/bin/bash

# BiblioVault Development Server Restart Script

echo "🔄 Restarting BiblioVault Development Environment..."
echo ""

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Stop servers
"$SCRIPT_DIR/stop-dev.sh"

echo ""
echo "⏳ Waiting 2 seconds..."
sleep 2
echo ""

# Start servers
"$SCRIPT_DIR/start-dev.sh"
