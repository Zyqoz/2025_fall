#!/bin/bash

# CareConnect Frontend Startup Script
echo "🎨 Starting CareConnect Frontend Application..."
echo "==============================================="

cd frontend

echo "Environment: Local Development"
echo "Port: 50030"
echo "Target: Chrome Browser"
echo ""

# Check if .env file exists and contains required variables
if [ ! -f ".env" ]; then
    echo "❌ Error: .env file not found!"
    echo "Please create frontend/.env file with required environment variables."
    echo "See LOCAL_DEVELOPMENT_SETUP.md for details."
    exit 1
fi

# Check for critical environment variables
if ! grep -q "CC_BASE_URL_WEB" .env; then
    echo "❌ Error: CC_BASE_URL_WEB not found in .env file!"
    echo "Please add: CC_BASE_URL_WEB=http://localhost:8080"
    exit 1
fi

echo "✅ Environment file validated"
echo ""

# Install dependencies if needed
echo "📦 Checking Flutter dependencies..."
flutter pub get

echo ""
echo "🚀 Starting Flutter web application..."
flutter run -d chrome --web-port=50030

echo ""
echo "Frontend application stopped."