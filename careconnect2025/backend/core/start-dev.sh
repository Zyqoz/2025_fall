#!/bin/bash

echo "🚀 Starting CareConnect Backend in Development Mode"
echo "=================================================="

# Check if we're in the right directory
if [ ! -f "pom.xml" ]; then
    echo "❌ Error: Please run this script from the backend/core directory"
    exit 1
fi

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "❌ Error: Java is not installed. Please install Java 17 first."
    exit 1
fi

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "❌ Error: Maven is not installed. Please install Maven first."
    exit 1
fi

echo "✅ Java and Maven found"
echo "✅ Using H2 in-memory database"
echo "✅ AWS services disabled"
echo "✅ Mocked external service configurations"
echo ""

echo "🔧 Starting Spring Boot application..."
echo "📊 H2 Console will be available at: http://localhost:8080/h2-console"
echo "📚 API Documentation at: http://localhost:8080/swagger-ui.html"
echo "🏥 Health check at: http://localhost:8080/actuator/health"
echo ""

# Run the application with dev profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
