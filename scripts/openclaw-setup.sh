#!/bin/bash

# OpenClaw Setup Script
# Installs and configures OpenClaw personal AI assistant for this workspace

set -e

echo "🦞 Setting up OpenClaw for this workspace..."

# Check Node.js version
NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1)
if [ -z "$NODE_VERSION" ] || [ "$NODE_VERSION" -lt 22 ]; then
    echo "❌ Node.js >= 22 is required. Current: $(node -v 2>/dev/null || echo 'not installed')"
    echo "   Install from https://nodejs.org/ or use nvm:"
    echo "   nvm install 22 && nvm use 22"
    exit 1
fi

echo "✅ Node.js version: $(node -v)"

# Check if OpenClaw is installed
if ! command -v openclaw &> /dev/null; then
    echo "📦 Installing OpenClaw..."
    npm install -g openclaw@latest
else
    echo "✅ OpenClaw is already installed: $(openclaw --version 2>/dev/null || echo 'installed')"
fi

# Create workspace skills directory if it doesn't exist
WORKSPACE_DIR="${OPENCLAW_WORKSPACE:-$(pwd)}"
SKILLS_DIR="$WORKSPACE_DIR/skills"

if [ -d "$SKILLS_DIR/performance-monitor" ]; then
    echo "✅ Performance monitor skill already exists"
else
    echo "⚠️  Skills directory not found at $SKILLS_DIR/performance-monitor"
    echo "   Make sure you run this from the repository root."
fi

echo ""
echo "🦞 OpenClaw setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Run 'openclaw onboard' to configure your assistant"
echo "2. Start the gateway: 'openclaw gateway --port 18789'"
echo "3. Test the skill: openclaw agent --message \"analyze my app performance\""
echo ""
echo "📁 Workspace skills are loaded from: $SKILLS_DIR"
echo "   The 'performance-monitor' skill is ready for use."
