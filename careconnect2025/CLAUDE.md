# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Frontend (Flutter)
- **Install dependencies**: `cd frontend && flutter pub get`
- **Run app**: `cd frontend && flutter run` (auto-detects platform)
- **Run web app**: `cd frontend && ./startup.sh` (starts on port 50030)
- **Run specific platform**: `flutter run -d chrome|android|ios|macos|windows|linux`
- **Build for web**: `flutter build web --base-href "/"`
- **Run tests**: `flutter test` or `./run-all-tests.sh` (comprehensive testing)
- **Test coverage**: `./test-coverage.sh`
- **Security check**: `./security-check.sh`

### Backend (Spring Boot)
- **Quick start**: `cd backend/core && ./run.sh` (loads environment and runs with dev profile)
- **Manual run**: `cd backend/core && ./mvnw spring-boot:run -Dspring-boot.run.profiles=dev`
- **Install dependencies**: `./mvnw clean install`
- **Run tests**: `./mvnw test`
- **Skip tests**: `./mvnw clean install -DskipTests`
- **Package for deployment**: `./mvnw package` (creates AWS Lambda-compatible zip)

### Environment Setup
- **Project setup**: `./setup.sh` (validates dependencies and installs packages)
- **Environment files**: 
  - Frontend: `.env` and `.env.local` in `frontend/` directory
  - Backend: Environment variables loaded via `run.sh` script

## Architecture Overview

### Project Structure
```
careconnect2025/
├── frontend/           # Flutter multi-platform app (web, mobile, desktop)
├── backend/core/       # Spring Boot REST API with JWT auth
└── terraform_aws/     # AWS infrastructure as code
```

### Frontend Architecture (Flutter)
- **State Management**: Provider pattern
- **Routing**: go_router for navigation
- **HTTP Client**: dio with cookie management
- **Key Features**: 
  - Multi-platform video calling (Agora + WebRTC)
  - Firebase integration (auth, messaging, firestore)
  - AI chat with voice commands
  - Health monitoring (Fitbit integration)
  - Payment processing (Stripe)
  - Real-time notifications

### Backend Architecture (Spring Boot)
- **Version**: Spring Boot 3.4.5 with Java 17
- **Database**: MySQL with JPA/Hibernate + Flyway migrations
- **Security**: JWT authentication with role-based access
- **Key Features**:
  - RESTful API with OpenAPI/Swagger documentation
  - WebSocket support for real-time communication
  - Firebase Admin SDK for push notifications
  - AWS integrations (S3, SSM Parameter Store)
  - AI service integration (OpenAI, LangChain4j)
  - Email services (SendGrid)
  - Payment processing (Stripe)

### Key Technologies
- **Frontend**: Flutter 3.8.1+, Provider, Firebase, Agora, WebRTC, Stripe
- **Backend**: Spring Boot 3.4.5, Spring Security, MySQL, AWS SDK, Firebase Admin
- **Infrastructure**: AWS (Lambda, RDS, S3, API Gateway), Terraform
- **Testing**: Flutter test framework, JUnit, Mockito

### Database Configuration
- **Development**: MySQL with auto-creation enabled
- **Migrations**: Flyway for database schema versioning
- **Connection**: Configured via environment variables

### Authentication Flow
- JWT-based authentication with refresh tokens
- Google OAuth integration
- Role-based authorization (Patient, Caregiver, Admin)
- Password reset via email verification

### Development Profiles
- **dev**: Local development with MySQL
- **test**: Testing profile with H2 in-memory database
- **prod**: Production profile for AWS deployment

## Environment Variables

### Frontend (.env)
```
API_BASE_URL=http://localhost:8080
FLUTTER_WEB_PORT=50030
DEEPSEEK_API_KEY=your_key
OPENAI_API_KEY=your_key
JWT_SECRET=your_secret
```

### Backend (via run.sh)
```
AWS_ENABLED=false
JDBC_URI=jdbc:mysql://localhost:3306/careconnect?createDatabaseIfNotExist=true
DB_USER=root
DB_PASSWORD=password
SECURITY_JWT_SECRET=your_jwt_secret
FIREBASE_PROJECT_ID=careconnectcapstone
```

## Testing
- **Frontend**: Comprehensive test suite with widget, integration, and unit tests
- **Backend**: JUnit tests with Spring Boot Test context
- **Test databases**: H2 for backend tests, no special setup for frontend tests

## Deployment
- **Frontend**: AWS Amplify deployment via `flutter build web`
- **Backend**: AWS Lambda deployment via Maven assembly plugin
- **Infrastructure**: Terraform scripts for complete AWS setup

## API Documentation
Once backend is running: http://localhost:8080/swagger-ui.html

## Common Issues
- Ensure MySQL is running for backend development
- Frontend requires .env file with API keys for full functionality
- Use Java 17 specifically for backend development
- Firebase service account file required in `backend/core/src/main/resources/`