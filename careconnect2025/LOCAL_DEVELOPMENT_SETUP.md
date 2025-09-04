# CareConnect Local Development Setup Guide

This guide will help you set up the CareConnect application locally for development. The application has been configured to run as a traditional web server (not serverless) with an H2 in-memory database.

## Prerequisites

Before starting, ensure you have the following installed:

### Required Software
- **Java 17+** (for backend)
- **Maven 3.6+** (for backend dependency management)
- **Flutter SDK** (latest stable version)
- **Chrome Browser** (for Flutter web development)
- **Git** (for version control)

### Verify Installations
```bash
# Check Java version
java --version

# Check Maven version
mvn --version

# Check Flutter version
flutter --version

# Check if Chrome is available for Flutter
flutter devices
```

## Quick Start

### 1. Clone and Navigate to Project
```bash
git clone [your-repo-url]
cd careconnect2025
```

### 2. Backend Setup

#### Configure Environment Variables
The backend is configured to run with H2 in-memory database and disabled external services for local development.

#### Start Backend Server
```bash
cd backend/core

# Method 1: Using Maven Spring Boot plugin (Recommended)
export JDBC_URI="jdbc:h2:mem:testdb;MODE=MySQL;DB_CLOSE_ON_EXIT=FALSE"
export DB_USER="sa"
export DB_PASSWORD=""
export HIBERNATE_DDL_AUTO="create"
export AWS_ENABLED="false"
export STRIPE_ENABLED="false"
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

# Method 2: Build JAR and run (Alternative)
./mvnw clean package -Pdefault -DskipTests
java -Dspring.profiles.active=dev -Dserver.port=8080 -jar target/careconnect-backend-0.0.1-SNAPSHOT.jar
```

**Backend should start on: http://localhost:8080**

### 3. Frontend Setup

#### Configure Environment Variables
Create or verify the frontend environment configuration:

```bash
cd frontend
```

Ensure your `.env` file contains:
```env
# Environment Configuration for Local Development
# API Configuration
API_BASE_URL=http://localhost:8080
FLUTTER_WEB_PORT=50030

# Backend Base URLs for different platforms (required by env_constant.dart)
CC_BASE_URL_WEB=http://localhost:8080
CC_BASE_URL_ANDROID=http://10.0.2.2:8080
CC_BASE_URL_OTHER=http://localhost:8080

# Firebase Configuration (using dummy values for local development)
FIREBASE_API_KEY=AIzaSyDummyKeyForLocalDevelopment
FIREBASE_PROJECT_ID=careconnectcapstone
FIREBASE_MESSAGING_SENDER_ID=663999888931
FIREBASE_APP_ID=1:663999888931:web:dummy-app-id-for-local

# Stripe Configuration (test mode disabled for local development)
STRIPE_PUBLISHABLE_KEY=pk_test_disabled_for_local_dev

# Agora Configuration (disabled for local development)
AGORA_APP_ID=dummy-agora-id-for-local-dev

# Debug Mode
DEBUG_MODE=true
```

#### Start Frontend Application
```bash
cd frontend

# Install dependencies (first time only)
flutter pub get

# Start the web application
flutter run -d chrome --web-port=50030
```

**Frontend should start on: http://localhost:50030**

## Access URLs

Once both services are running:

- **Frontend Web App**: http://localhost:50030
- **Backend API**: http://localhost:8080
- **H2 Database Console**: http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:testdb`
  - Username: `sa`
  - Password: (leave blank)

## Test User Account

For testing, you can create a user account through the registration form, or use the backend API directly:

```bash
# Create a test user via API
curl -X POST http://localhost:8080/v1/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "password123",
    "role": "PATIENT"
  }'
```

Login credentials:
- **Email**: test@example.com
- **Password**: password123

## Development Configuration

### Backend Features Disabled for Local Development
- AWS S3 storage (using database storage instead)
- Stripe payments (registration works without payment)
- Email services (console mode)
- External APIs (using dummy configurations)

### Database
- **Type**: H2 in-memory database
- **Mode**: MySQL compatibility
- **Schema**: Auto-created on startup
- **Data**: Resets on application restart

## Troubleshooting

### Common Issues and Solutions

#### Backend Won't Start
1. **Check Java version**: Ensure Java 17+ is installed
2. **Port conflict**: Make sure port 8080 is available
3. **Dependencies**: Run `./mvnw clean install` to refresh dependencies

#### Frontend Won't Start
1. **Flutter setup**: Run `flutter doctor` to check setup
2. **Dependencies**: Run `flutter pub get` to install dependencies
3. **Chrome not available**: Ensure Chrome is installed and available to Flutter

#### Environment Variables Not Loading
1. **Check .env file**: Ensure `.env` file exists in frontend directory
2. **Required variables**: Verify all CC_BASE_URL_* variables are set
3. **Restart Flutter**: Stop and restart Flutter app after .env changes

#### WebSocket Connection Errors
These are expected in local development. The app will function without real-time features.

### Logs and Debugging

#### Backend Logs
Check the terminal where you started the backend for error logs.

#### Frontend Logs
- Check the terminal where you started Flutter
- Use Chrome DevTools (F12) for web debugging
- Flutter DevTools URL will be shown in terminal

## Development Workflow

1. **Make Changes**: Edit code in your preferred IDE
2. **Backend**: Restart Spring Boot application to see changes
3. **Frontend**: Use Flutter hot reload (press 'r' in terminal) for instant updates
4. **Database**: Check H2 console for data verification
5. **API Testing**: Use tools like Postman or curl for API testing

## Team Development Tips

- **Backend changes**: Always test with `./mvnw spring-boot:run -Dspring-boot.run.profiles=dev`
- **Frontend changes**: Use Flutter hot reload for faster development
- **Database**: Remember that H2 data resets on backend restart
- **Environment**: Each developer can modify their local `.env` without affecting others
- **Testing**: Create test accounts through the registration flow

## Next Steps

Once you have the application running:
1. Explore the codebase structure
2. Test user registration and login
3. Verify API endpoints work correctly
4. Start implementing new features
5. Run tests before committing changes

## Support

If you encounter issues:
1. Check this guide first
2. Review error logs in terminal
3. Ask team members who have successfully set up the environment
4. Document new issues and solutions for future reference

---

**Happy coding! 🚀**