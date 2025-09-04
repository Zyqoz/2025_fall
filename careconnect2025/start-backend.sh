#!/bin/bash

# CareConnect Backend Startup Script
echo "🚀 Starting CareConnect Backend Server..."
echo "================================="

cd backend/core

# Set environment variables for local development
export JDBC_URI="jdbc:h2:mem:testdb;MODE=MySQL;DB_CLOSE_ON_EXIT=FALSE"
export DB_USER="sa"
export DB_PASSWORD=""
export HIBERNATE_DDL_AUTO="create"
export AWS_ENABLED="false"
export STRIPE_ENABLED="false"

echo "Environment: Local Development"
echo "Database: H2 In-Memory"
echo "Port: 8080"
echo "Profile: dev"
echo ""

# Start the backend server
echo "Starting Spring Boot application..."
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

echo ""
echo "Backend server stopped."