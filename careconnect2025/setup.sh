#!/bin/bash

echo "🚀 CareConnect 2025 Setup Script"
echo "================================="

# Check if we're in the right directory
if [ ! -f "frontend/pubspec.yaml" ] || [ ! -f "backend/core/pom.xml" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

echo "✅ Project structure verified"

# Check Flutter installation
if command -v flutter &> /dev/null; then
    echo "✅ Flutter is installed"
    flutter --version
else
    echo "❌ Flutter is not installed. Please install Flutter first:"
    echo "   https://docs.flutter.dev/get-started/install"
    exit 1
fi

# Check Java installation
if command -v java &> /dev/null; then
    echo "✅ Java is installed"
    java -version
else
    echo "❌ Java is not installed. Please install Java 17 first:"
    echo "   https://adoptium.net/temurin/releases/?version=17"
    exit 1
fi

# Check Maven installation
if command -v mvn &> /dev/null; then
    echo "✅ Maven is installed"
    mvn --version
else
    echo "❌ Maven is not installed. Please install Maven first:"
    echo "   https://maven.apache.org/install.html"
    exit 1
fi

# Check MySQL installation
if command -v mysql &> /dev/null; then
    echo "✅ MySQL is installed"
    mysql --version
else
    echo "⚠️  MySQL is not installed. You'll need it for the backend."
    echo "   Install from: https://dev.mysql.com/downloads/mysql/"
fi

echo ""
echo "🔧 Setting up Frontend..."
cd frontend

# Make startup script executable
chmod +x startup.sh

# Install Flutter dependencies
echo "Installing Flutter dependencies..."
flutter pub get

if [ $? -eq 0 ]; then
    echo "✅ Frontend dependencies installed"
else
    echo "❌ Failed to install frontend dependencies"
    exit 1
fi

echo ""
echo "🔧 Setting up Backend..."
cd ../backend/core

# Make scripts executable
chmod +x run.sh
chmod +x mvnw

# Install Maven dependencies
echo "Installing Maven dependencies..."
./mvnw clean install -DskipTests

if [ $? -eq 0 ]; then
    echo "✅ Backend dependencies installed"
else
    echo "❌ Failed to install backend dependencies"
    exit 1
fi

echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Copy frontend/env.template to frontend/.env and update with your API keys"
echo "2. Start MySQL database service"
echo "3. Start the backend: cd backend/core && ./run.sh"
echo "4. Start the frontend: cd frontend && ./startup.sh"
echo ""
echo "For detailed instructions, see README.md"

